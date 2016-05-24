%%load('stripped.mat')

%check for sequences that their length >= 40

vec_idx=zeros();
idx=1;

for i=1:size(stripped,1)
    if ~isnan(stripped(i,40))
       vec_idx(idx)=i;
       idx=idx+1;
    end
end

cleaned_data=zeros(length(vec_idx),size(stripped,2));

for i=1:length(vec_idx)
    cleaned_data(i,:)=stripped(vec_idx(i),:);
end

%delete duplicates

vec_dup_idx=zeros();
idx=1;

for i=1:size(cleaned_data,1)
    for j=1:size(cleaned_data,2)
        if min(cleaned_data(i,:)-cleaned_data(j,:))==0 && max(cleaned_data(i,:)-cleaned_data(j,:))==0
           vec_dup_idx(idx)=i;
           idx=idx+1;
        end
    end
    disp(i)
end

cleaned_data(vec_dup_idx,:)=[];

%check for any gaps or non numeric values
vec_str_idx=zeros();
idx=1;

for i=1:size(cleaned_data,1)
    for j=1:size(cleaned_data,2)
        if j+1<=size(cleaned_data,2) && j-1>=1 && ischar(cleaned_data(i,j-1)) && ischar(cleaned_data(i,j+1))
           vec_str_idx(idx)=i;
           idx=idx+1;
        end
    end
    disp(i)
end

save('cleaned_data','cleaned_data')