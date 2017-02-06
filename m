From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: CBT: New RGW getput benchmark and testing diary
Date: Mon, 6 Feb 2017 10:33:26 -0500 (EST)
Message-ID: <1143254675.101053582.1486395206606.JavaMail.zimbra@redhat.com>
References: <8700753c-8440-695e-d529-e83b0fb2ba90@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:57038 "EHLO
        mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdBFPd2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 10:33:28 -0500
In-Reply-To: <8700753c-8440-695e-d529-e83b0fb2ba90@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com, Mark Seger <mjseger@gmail.com>, Kyle Bader <kbader@redhat.com>, Karan Singh <karan@redhat.com>, Brent Compton <bcompton@redhat.com>

Thanks for the detailed effort and analysis, Mark.

As we get closer to the L time-frame, it should become relevant to look at the relative boost::asio frontend rework i/o paths, which are the open effort to reduce CPU overhead/revise threading model, in general.

Matt

----- Original Message -----
> From: "Mark Nelson" <mnelson@redhat.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com
> Cc: "Mark Seger" <mjseger@gmail.com>, "Kyle Bader" <kbader@redhat.com>, "Karan Singh" <karan@redhat.com>, "Brent
> Compton" <bcompton@redhat.com>
> Sent: Monday, February 6, 2017 12:55:20 AM
> Subject: CBT: New RGW getput benchmark and testing diary
> 
> Hi All,
> 
> Over the weekend I took a stab at improving our ability to run RGW
> performance tests in CBT.  Previously the only way to do this was to use
> the cosbench plugin, which required a fair amount of additional
> setup and while quite powerful can be overkill in situations where you
> want to rapidly iterate over tests looking for specific issues.  A while
> ago Mark Seger from HP told me he had created a swift benchmark called
> "getput" that is written in python and is much more convenient to run
> quickly in an automated fashion.  Normally getput is used in conjunction
> with gpsuite, a tool for coordinating benchmarking multiple getput
> processes.  This is how you would likely use getput on a typical ceph or
> swift cluster, but since CBT builds the cluster and has it's own way for
> launching multiple benchmark processes, it uses getput directly.
> 


-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
