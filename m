From: Greg Farnum <greg@inktank.com>
Subject: Re: When ceph synchronizes journal to disk? / read request
Date: Tue, 5 Mar 2013 12:13:41 -0800
Message-ID: <D26E8E3336DA442CA74303D35DCD2B99@inktank.com>
References: <513343D8.8050402@cs.utah.edu>
 <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com>
 <51357589.6080202@cs.utah.edu> <20130305083702.GA12118@oder>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:54957 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab3CEUNp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 15:13:45 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so4951717pbc.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 12:13:45 -0800 (PST)
In-Reply-To: <20130305083702.GA12118@oder>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dieter Kasper <d.kasper@kabelmail.de>
Cc: Xing Lin <xinglin@cs.utah.edu>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Tuesday, March 5, 2013 at 12:37 AM, Dieter Kasper wrote:
> Hi Gregory,
> 
> another interesting aspect for me is:
> How will a read-request for this block/sub-block (pending between journal and OSD)
> be satisfied (assuming the client will not cache) ?
> Will this read go to the journal or to the OSD ?
> 
All read requests are satisfied from the main OSD store filesystem. Satisfying reads from the journal would be extraordinarily complicated and not buy us anything that I can think of. (In fact the journal is only read during recovery).
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com 


