From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph osd df
Date: Sat, 10 Jan 2015 10:39:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501101027390.26676@cobra.newdream.net>
References: <alpine.DEB.2.00.1501051101010.6168@cobra.newdream.net> <20150110093158.GA2288@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbbAJSjv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 10 Jan 2015 13:39:51 -0500
In-Reply-To: <20150110093158.GA2288@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <trociny@FreeBSD.org>
Cc: ceph-devel@vger.kernel.org

On Sat, 10 Jan 2015, Mykola Golub wrote:
> On Mon, Jan 05, 2015 at 11:03:40AM -0800, Sage Weil wrote:
> > We see a fair number of issues and confusion with OSD utilization and 
> > unfortunately there is easy way to see a summary of the current OSD 
> > utilization state.  'ceph pg dump' includes raw data but it not very 
> > friendly.  'ceph osd tree' shows weights but not actual utilization.  
> > 'ceph health detail' tells you the nearfull osds but only when they reach 
> > the warning threshold.
> > 
> > Opened a ticket for a new command that summarizes just the relevant info:
> > 
> > 	http://tracker.ceph.com/issues/10452
> > 
> > Suggestions welcome.  It's a pretty simple implementation (the mon has 
> > all the info; just need to add the command to present it) so I'm hoping it 
> > can get into hammer.  If anyone is interested in doing the 
> > implementation that would be great too!
> 
> I am interested in implementing this.
> 
> Here is my approach, for preliminary review and discussion.
>
> https://github.com/ceph/ceph/pull/3347

Awesome!  I made a few comments on the pull request.

> Only plane text format is available currently. As both "osd only" and
> "tree" outputs look useful I implemented both and added "tree" option
> to tell which to choose.

This sounds fine to me.  We will want to include the formatted output 
before merging, though!

> In http://tracker.ceph.com/issues/10452#note-2 Travis Rhoden suggested
> to extend 'ceph osd tree' command to provide this data instead, but
> I prefer to have many small specialized commands instead of one with
> large output. But if other people also think that it is better to add
> a '--detail' to osd tree instead of new command, I will change this.

Works for me.
 
> Also, I am not sure I got an idea how standard deviation should be
> calculated. Sage's note in 10452:
> 
>  - standard deviation (of normalized
>    actual_osd_utilization/crush_weight/reweight value)
>    
> I don't see why utilization should be normalized by
> reweight/crush_weight ratio? As I understand the goal is to have
> utilization be the same for all devices (thus deviation as small as
> possible), does not matter what reweight values we have?

Yeah, I think you're right.  If I'm reading the code correct you're still 
including reweight in there but I think it can be safely dropped.

> Some examples of command output for my dev environments:
> 
>  % ceph osd df
>  ID WEIGHT REWEIGHT %UTIL VAR  
>  0    1.00     1.00 18.12 1.00 
>  1    1.00     1.00 18.14 1.00 
>  2    1.00     1.00 18.13 1.00 

I wonder if we should try to standardize the table formats.  'ceph osd 
tree' current looks like

# id	weight	type name	up/down	reweight
-1	3	root default
-2	3		host maetl
0	1			osd.0	up	1	
1	1			osd.1	up	1	
2	1			osd.2	up	1	

That is, lowercase headers (with a # header prefix).  It's also not using 
TableFormatter (which it predates).

It's also pretty sloppy with the precision and formatting:

$ ./ceph osd crush reweight osd.1 
.0001
reweighted item id 1 name 'osd.1' to 0.0001 in crush map
$ ./ceph osd tree
# id	weight	type name	up/down	reweight
-1	2	root default
-2	2		host maetl
0	1			osd.0	up	1	
1	9.155e-05			osd.1	up	1	
2	1			osd.2	up	1	
$ ./ceph osd crush reweight osd.1 .001
reweighted item id 1 name 'osd.1' to 0.001 in crush map
$ ./ceph osd tree
# id	weight	type name	up/down	reweight
-1	2.001	root default
-2	2.001		host maetl
0	1			osd.0	up	1	
1	0.0009918			osd.1	up	1	
2	1			osd.2	up	1	

Given that the *actual* precision of these weights is 16.16 bit 
fixed-point, that's a lower bound of .00001.  I'm not sure we want to 
print 1.00000 all the time, though?  Although I suppose it's better than

      1
      2
 .00001

In a perfect world I suppose TableFormatter (or whatever) would adjust the 
precision of all printed values to the highest precision needed by any 
item in the list, but maybe just sticking to 5 digits for 
everything is best for simplicity.

Anyway, any interest in making a single stringify_weight() helper and 
fixing up 'ceph osd tree' to also use it and TableFormatter too?  :)

sage


>  --
>  AVG %UTIL: 18.13  MIN/MAX VAR: 1.00/1.00  DEV: 0
>  
>  % ceph osd df tree
>  ID WEIGHT REWEIGHT %UTIL VAR  NAME            
>  -1   3.00        - 18.13 1.00 root default    
>  -2   3.00        - 18.13 1.00     host zhuzha 
>  0    1.00     1.00 18.12 1.00         osd.0   
>  1    1.00     1.00 18.14 1.00         osd.1   
>  2    1.00     1.00 18.13 1.00         osd.2   
>  --
>  AVG %UTIL: 18.13  MIN/MAX VAR: 1.00/1.00  DEV: 0
>  
>  % ceph osd df
>  ID WEIGHT REWEIGHT %UTIL VAR  
>  0    1.00     1.00 38.15 0.91 
>  1    1.00     1.00 44.15 1.06 
>  2    1.00     1.00 45.66 1.09 
>  3    1.00     1.00 44.15 1.06 
>  4    1.00     0.80 36.82 0.88 
>  --
>  AVG %UTIL: 41.78  MIN/MAX VAR: 0.88/1.09  DEV: 6.19
>  
>  % ceph osd df tree
>  ID WEIGHT REWEIGHT %UTIL VAR  NAME          
>  -1   5.00        - 41.78 1.00 root default  
>  -2   1.00        - 38.15 0.91     host osd1 
>  0    1.00     1.00 38.15 0.91         osd.0 
>  -3   1.00        - 44.15 1.06     host osd2 
>  1    1.00     1.00 44.15 1.06         osd.1 
>  -4   1.00        - 45.66 1.09     host osd3 
>  2    1.00     1.00 45.66 1.09         osd.2 
>  -5   1.00        - 44.15 1.06     host osd4 
>  3    1.00     1.00 44.15 1.06         osd.3 
>  -6   1.00        - 36.82 0.88     host osd5 
>  4    1.00     0.80 36.82 0.88         osd.4 
>  --
>  AVG %UTIL: 41.78  MIN/MAX VAR: 0.88/1.09  DEV: 6.19
> 
> -- 
> Mykola Golub
> 
> 
