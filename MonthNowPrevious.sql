-- Getting month ranges

--First you need to figure out the current date:

declare @today datetime
select @today=getdate()
--Let’s start with the current month:

--Make the Assumption for examples I am working with a date of  January, 30th. So the first day of the month is January, 1st. 
--Unfortunately, you cannot directly set the day to 1. But you can extract the day from the date, in our case 30 and 1 is 30 – (30 – 1), so:

select dateadd(dd,-(day(@today)-1),@today)
--This will return: Jan 1 2013 1:49PM

--So basically we have the right date but for comparison purposes, we’d rather have midnight than 1:49pm. 
--In order to do it, you need to convert it to a date string and back to a datetime:

select convert(datetime, convert(varchar(10),dateadd(dd,-(day(@today)-1),@today),101))
--Now we get: Jan 1 2013 12:00AM
--if you’re only interested in a string containing the date, just drop the outer convert:


select convert(varchar(10),dateadd(dd,-(day(@today)-1),@today),101)
--Use another format than 101 if needed. The complete list of date conversion formats can be found here. For example, for the German date format, use 104 (dd.mm.yyyy).

--MULTIPE PARTS HERE --- Now let’s get the last day of the current month. This is basically the day before the first day of next month.

--So first let’s get the first day of next month. 
--      This is actually just 1 month later than the first day of the current month:

select convert(varchar(10),dateadd(mm,1,dateadd(dd,-(day(@today)-1),@today)),101) as 'First day of next month.'   -- Part one of last day of current month
--This returns: 02/01/2013

--Now let’s just substract one day and we’ll get the last day of the current month:

select convert(varchar(10),dateadd(dd,-1,dateadd(mm,1,dateadd(dd,-(day(@today)-1),@today))),101) as 'last day of the current month'
--This returns: 01/31/2013

--Since we already have the first day of next month, let’s get the last day of next month. 
--      This is basically the same again but instead of adding 1 month, you add 2 months:

select convert(varchar(10),dateadd(mm,2,dateadd(dd,-day(@today),@today)),101) as 'last day of next month'
--This returns: 02/28/2013

--Now let’s tackle the previous month. 
--        The first day of last month is basically the first day of the current month minus 1 month:

select convert(varchar(10),dateadd(mm,-1,dateadd(dd,-(day(@today)-1),@today)),101) as 'first day of last month'
--This returns: 12/01/2012

--And then the last day of previous month. It is one day before the first day of the current month:


select convert(varchar(10),dateadd(dd,-(day(@today)),@today),101) as 'last day of previous month'
--This returns: 12/31/2012
