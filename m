From: "Plaetinck, Dieter" <dieter@vimeo.com>
Subject: Re: Ceph benchmarks
Date: Tue, 28 Aug 2012 13:51:46 +0200
Message-ID: <20120828135146.192fccab@dieter-t420s>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ny-iacmail.iac.com ([63.119.10.45]:24262 "EHLO
	ny-iacmail.iac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab2H1L6I convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 07:58:08 -0400
In-Reply-To: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?U8OpYmFzdGllbg==?= Han <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

S=C3=A9bastien Han <han.sebastien@gmail.com> wrote:

> Just as a reminder the system maintains 2 caches facilities:
> * disk write cache
> * page cache

the page cache is the one commonly referred to as block cache right (i.=
e. in the block layer, below the filesystem layer in the kernel)?
what do you mean with disk write cache? the one where io commands are h=
eld so they can be reordered? I always thought that was the same as the=
 block cache - and also hard disks sometimes do this themselves, buffer=
ing in a few megs of memory on the hard disk itself?

Dieter
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
