From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Port no For data Transfer between OSDs
Date: Wed, 05 Sep 2012 11:14:56 +0200
Message-ID: <50471810.6000608@widodh.nl>
References: <CAGfy=6mz04CoytQdt4Zj-RdOqU+0XEv3eHAuPQ1E-Pu=6gAa+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:35795 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab2IEJO6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 05:14:58 -0400
In-Reply-To: <CAGfy=6mz04CoytQdt4Zj-RdOqU+0XEv3eHAuPQ1E-Pu=6gAa+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 09/05/2012 07:30 AM, hemant surale wrote:
> Hi Community ,
>              I want to trace the data transfer rates occurring between
> osds while injecting data into ceph cluster. Can you please tell me
> what ports should I monitor or keep track of?
>              Thanks !

OSDs start binding from port 6800 and counting up from there.

For example, a machine with 4 OSDs running:

root@atom0:~# netstat -nap|grep LISTEN|grep -E ^tcp|grep ceph-osd
tcp6       0      0 :::6800                 :::* 
LISTEN      24329/ceph-osd
tcp6       0      0 :::6801                 :::* 
LISTEN      24329/ceph-osd
tcp6       0      0 :::6802                 :::* 
LISTEN      24329/ceph-osd
tcp6       0      0 :::6803                 :::* 
LISTEN      24596/ceph-osd
tcp6       0      0 :::6804                 :::* 
LISTEN      24596/ceph-osd
tcp6       0      0 :::6805                 :::* 
LISTEN      24596/ceph-osd
tcp6       0      0 :::6806                 :::* 
LISTEN      25316/ceph-osd
tcp6       0      0 :::6807                 :::* 
LISTEN      25316/ceph-osd
tcp6       0      0 :::6808                 :::* 
LISTEN      25316/ceph-osd
tcp6       0      0 :::6809                 :::* 
LISTEN      25839/ceph-osd
tcp6       0      0 :::6810                 :::* 
LISTEN      25839/ceph-osd
tcp6       0      0 :::6811                 :::* 
LISTEN      25839/ceph-osd
root@atom0:~#

Wido

>
> Regards,
> Hemant Surale.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

