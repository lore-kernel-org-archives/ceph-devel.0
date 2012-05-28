From: Tomoki BENIYA <beniya@bit-isle.co.jp>
Subject: Re: Always creating PGs
Date: Mon, 28 May 2012 18:42:41 +0900
Message-ID: <20120528183855.CBC3.33BC0F0F@bit-isle.co.jp>
References: <20120510175036.FC97.33BC0F0F@bit-isle.co.jp> <CADvuQRHRSUjA15cX_7ro5vP4jVdg9phugKvcwqZHa3BsM+6RxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41491 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752371Ab2E1JsG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 May 2012 05:48:06 -0400
Received: by pbbrp16 with SMTP id rp16so3677504pbb.10
        for <ceph-devel@vger.kernel.org>; Mon, 28 May 2012 02:48:04 -0700 (PDT)
In-Reply-To: <CADvuQRHRSUjA15cX_7ro5vP4jVdg9phugKvcwqZHa3BsM+6RxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I upgraded 0.47.
I had confirmed to have been resolved this problem.

Thank you.


On Thu, 10 May 2012 15:10:50 -0700
Tommi Virtanen <tv@inktank.com> wrote:

> On Thu, May 10, 2012 at 2:17 AM, Tomoki BENIYA <beniya@bit-isle.co.jp> wrote:
> > I found that PGs of 'creating' status are never finished.
> >
> > # ceph pg stat
> > v17596: 1204 pgs: 8 creating, 1196 active+clean; 25521 MB data, 77209 MB used, 2223 GB / 2318 GB avail
> > ? ? ? ? ? ? ? ? ?~~~~~~~~~~
> > ? ? ? ? ? ? ? ? ?always creating, why?
> >
> > # ceph pg dump|grep creating
> > 1.1p6 ? 0 ? ? ? 0 ? ? ? 0 ? ? ? 0 ? ? ? 0 ? ? ? 0 ? ? ? 0 ? ? ? creating ? ? ? ?0.000000 ? ? ? ?0'0 ? ? 0'0 ? ? [] ? ? ?[] ? ? ?0'0 ? ? 0.000000
> 
> Sounds like another report we've had recently, under the subject "PGs
> stuck in creating state"
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/6078
> 
> Please read that thread. That wart should go away at 0.47.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Tomoki BENIYA <beniya@bit-isle.co.jp>

