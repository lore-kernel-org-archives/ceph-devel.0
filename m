From: Mykola Golub <trociny@FreeBSD.org>
Subject: Re: ceph osd df
Date: Sat, 10 Jan 2015 11:31:59 +0200
Message-ID: <20150110093158.GA2288@gmail.com>
References: <alpine.DEB.2.00.1501051101010.6168@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:59677 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbAJJcE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Jan 2015 04:32:04 -0500
Received: by mail-la0-f46.google.com with SMTP id q1so18088649lam.5
        for <ceph-devel@vger.kernel.org>; Sat, 10 Jan 2015 01:32:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1501051101010.6168@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 05, 2015 at 11:03:40AM -0800, Sage Weil wrote:
> We see a fair number of issues and confusion with OSD utilization and 
> unfortunately there is easy way to see a summary of the current OSD 
> utilization state.  'ceph pg dump' includes raw data but it not very 
> friendly.  'ceph osd tree' shows weights but not actual utilization.  
> 'ceph health detail' tells you the nearfull osds but only when they reach 
> the warning threshold.
> 
> Opened a ticket for a new command that summarizes just the relevant info:
> 
> 	http://tracker.ceph.com/issues/10452
> 
> Suggestions welcome.  It's a pretty simple implementation (the mon has 
> all the info; just need to add the command to present it) so I'm hoping it 
> can get into hammer.  If anyone is interested in doing the 
> implementation that would be great too!

I am interested in implementing this.

Here is my approach, for preliminary review and discussion.

https://github.com/ceph/ceph/pull/3347

Only plane text format is available currently. As both "osd only" and
"tree" outputs look useful I implemented both and added "tree" option
to tell which to choose.

In http://tracker.ceph.com/issues/10452#note-2 Travis Rhoden suggested
to extend 'ceph osd tree' command to provide this data instead, but
I prefer to have many small specialized commands instead of one with
large output. But if other people also think that it is better to add
a '--detail' to osd tree instead of new command, I will change this.

Also, I am not sure I got an idea how standard deviation should be
calculated. Sage's note in 10452:

 - standard deviation (of normalized
   actual_osd_utilization/crush_weight/reweight value)
   
I don't see why utilization should be normalized by
reweight/crush_weight ratio? As I understand the goal is to have
utilization be the same for all devices (thus deviation as small as
possible), does not matter what reweight values we have?

Some examples of command output for my dev environments:

 % ceph osd df
 ID WEIGHT REWEIGHT %UTIL VAR  
 0    1.00     1.00 18.12 1.00 
 1    1.00     1.00 18.14 1.00 
 2    1.00     1.00 18.13 1.00 
 --
 AVG %UTIL: 18.13  MIN/MAX VAR: 1.00/1.00  DEV: 0
 
 % ceph osd df tree
 ID WEIGHT REWEIGHT %UTIL VAR  NAME            
 -1   3.00        - 18.13 1.00 root default    
 -2   3.00        - 18.13 1.00     host zhuzha 
 0    1.00     1.00 18.12 1.00         osd.0   
 1    1.00     1.00 18.14 1.00         osd.1   
 2    1.00     1.00 18.13 1.00         osd.2   
 --
 AVG %UTIL: 18.13  MIN/MAX VAR: 1.00/1.00  DEV: 0
 
 % ceph osd df
 ID WEIGHT REWEIGHT %UTIL VAR  
 0    1.00     1.00 38.15 0.91 
 1    1.00     1.00 44.15 1.06 
 2    1.00     1.00 45.66 1.09 
 3    1.00     1.00 44.15 1.06 
 4    1.00     0.80 36.82 0.88 
 --
 AVG %UTIL: 41.78  MIN/MAX VAR: 0.88/1.09  DEV: 6.19
 
 % ceph osd df tree
 ID WEIGHT REWEIGHT %UTIL VAR  NAME          
 -1   5.00        - 41.78 1.00 root default  
 -2   1.00        - 38.15 0.91     host osd1 
 0    1.00     1.00 38.15 0.91         osd.0 
 -3   1.00        - 44.15 1.06     host osd2 
 1    1.00     1.00 44.15 1.06         osd.1 
 -4   1.00        - 45.66 1.09     host osd3 
 2    1.00     1.00 45.66 1.09         osd.2 
 -5   1.00        - 44.15 1.06     host osd4 
 3    1.00     1.00 44.15 1.06         osd.3 
 -6   1.00        - 36.82 0.88     host osd5 
 4    1.00     0.80 36.82 0.88         osd.4 
 --
 AVG %UTIL: 41.78  MIN/MAX VAR: 0.88/1.09  DEV: 6.19

-- 
Mykola Golub
