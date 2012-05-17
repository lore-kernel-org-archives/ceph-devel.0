From: Sage Weil <sage@inktank.com>
Subject: Re: Journal too small
Date: Thu, 17 May 2012 09:01:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205170901100.7019@cobra.newdream.net>
References: <201205171259.55967.karol.jurak@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35318 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760102Ab2EQQB6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 12:01:58 -0400
In-Reply-To: <201205171259.55967.karol.jurak@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Jurak <karol.jurak@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 17 May 2012, Karol Jurak wrote:
> Hi,
> 
> During an ongoing recovery in one of my clusters a couple of OSDs 
> complained about too small journal. For instance:
> 
> 2012-05-12 13:31:04.034144 7f491061d700  1 journal check_for_full at 
> 863363072 : JOURNAL FULL 863363072 >= 1048571903 (max_size 1048576000 
> start 863363072)
> 2012-05-12 13:31:04.034680 7f491061d700  0 journal JOURNAL TOO SMALL: item 
> 1693745152 > journal 1048571904 (usable)
> 
> I was under the impression that the OSDs stopped participating in recovery 
> after this event. (ceph -w showed that the number of PGs in state 
> active+clean no longer increased.) They resumed recovery after I enlarged 
> their journals (stop osd, --flush-journal, --mkjournal, start osd).
> 
> How serious is such situation? Do the OSDs know how to handle it 
> correctly? Or could this result in some data loss or corruption? After the 
> recovery finished (ceph -w showed that all PGs are in active+clean state) 
> I noticed that a few rbd images were corrupted.

The osds tolerate the full journal.  There will be a big latency spike, 
but they'll recover without risking data.  You should definitely increase 
the journal size if this happens regulary, though.

sage

> 
> The cluster runs v0.46. The OSDs use ext4. I'm pretty sure that during the 
> recovery no clients were accessing the cluster.
> 
> Best regards,
> Karol
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
