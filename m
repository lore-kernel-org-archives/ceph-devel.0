From: Karol Jurak <karol.jurak@gmail.com>
Subject: Re: Journal too small
Date: Fri, 18 May 2012 12:58:49 +0200
Message-ID: <201205181258.49273.karol.jurak@gmail.com>
References: <201205171259.55967.karol.jurak@gmail.com> <Pine.LNX.4.64.1205170901100.7019@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39949 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2ERK6x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 06:58:53 -0400
Received: by weyu7 with SMTP id u7so1726041wey.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 03:58:52 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205170901100.7019@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thursday 17 of May 2012 18:01:55 Sage Weil wrote:
> On Thu, 17 May 2012, Karol Jurak wrote:
> > Hi,
> > 
> > During an ongoing recovery in one of my clusters a couple of OSDs
> > complained about too small journal. For instance:
> > 
> > 2012-05-12 13:31:04.034144 7f491061d700  1 journal check_for_full at
> > 863363072 : JOURNAL FULL 863363072 >= 1048571903 (max_size 1048576000
> > start 863363072)
> > 2012-05-12 13:31:04.034680 7f491061d700  0 journal JOURNAL TOO SMALL:
> > item 1693745152 > journal 1048571904 (usable)
> > 
> > I was under the impression that the OSDs stopped participating in
> > recovery after this event. (ceph -w showed that the number of PGs in
> > state active+clean no longer increased.) They resumed recovery after
> > I enlarged their journals (stop osd, --flush-journal, --mkjournal,
> > start osd).
> > 
> > How serious is such situation? Do the OSDs know how to handle it
> > correctly? Or could this result in some data loss or corruption?
> > After the recovery finished (ceph -w showed that all PGs are in
> > active+clean state) I noticed that a few rbd images were corrupted.
> 
> The osds tolerate the full journal.  There will be a big latency spike,
> but they'll recover without risking data.  You should definitely
> increase the journal size if this happens regulary, though.

Thank you for clarification and advice.

Karol
