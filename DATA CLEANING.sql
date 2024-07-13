## DATA CLEANINGG


select * from   layoffs;


create table layoffs_staging like layoffs;

select * from   layoffs_staging;
insert layoffs_staging select * from layoffs;
select * ,row_number() over(partition by company,location,country,
stage,funds_raised_millions,industry,total_laid_off,
percentage_laid_off,`date`) as row_num
from layoffs_staging;

with dummy_cte as
(
select * ,row_number() over(partition by company,location,country,
stage,funds_raised_millions,industry,total_laid_off,
percentage_laid_off,`date`) as row_num
from layoffs_staging
);
create TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select * from   layoffs_staging2;
insert into layoffs_staging2
select * ,row_number() over(partition by company,location,country,
stage,funds_raised_millions,industry,total_laid_off,
percentage_laid_off,`date`) as row_num
from layoffs_staging;
select * from layoffs_staging2
where row_num>1;
delete from layoffs_staging2
where row_num>1;

##  STANDARDIZING DATA
select company ,trim(company)from layoffs_staging2;
update layoffs_staging2 set company=trim(company);
select * from layoffs_staging2
;
select distinct industry from layoffs_staging2
order by 1
;
select * from layoffs_staging2
where industry like 'crypto%';
update layoffs_staging2 set industry='Crypto'
where industry like 'crypto%';
select distinct location from layoffs_staging2
order by 1
;
select distinct country from layoffs_staging2
order by 1
;
update layoffs_staging2 set country='United states'
where country like 'United States%';
select `date`
from layoffs_staging2;
select `date`,
str_to_date(`date`,'%m/%d/%Y') as new_date
from layoffs_staging2;
update layoffs_staging2
set date =str_to_date(`date`,'%m/%d/%Y')  
;
select * from layoffs_staging2;
Alter table layoffs_staging2
modify column `date` date;
select * from layoffs_staging2
where total_laid_off is null and  percentage_laid_off is null
;
select * from layoffs_staging2
 where industry is null or industry='';
 select * from layoffs_staging2 where company='Airbnb';
 select * from layoffs_staging2 tab11
 join layoffs_staging2 tab22 on tab11.company=tab22.company
 where(tab11.industry is null or tab11.industry='')
 and tab22.industry is not null;
 update  layoffs_staging2 tab1
join layoffs_staging2 tab2
on tab1.company=tab2.company
set tab1.industry=tab2.industry
where tab1.industry is null 
and tab2.industry is not null;
update layoffs_staging2 
set industry=null
where industry='';
select * from layoffs_staging2
where total_laid_off is null and  percentage_laid_off is null
;
delete from layoffs_staging2
where total_laid_off is null and  percentage_laid_off is null;
select * from layoffs_staging2
;
alter table layoffs_staging2
drop column row_num;