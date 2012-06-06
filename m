From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Can we mount cephfs in centos 5.7 ?
Date: Wed, 6 Jun 2012 09:24:25 -0700
Message-ID: <CADvuQRFuvg5syrnfNEwnQ=5rwPJ-Gee3WhxHKd+bmJM3FWK2Bw@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D01790CEA@WHQBEMAIL1.whq.wistron>
 <CAAs1YtF5UkoG1O6yKBZq0KY4Z-MDsQ2K9VxneySpr5+JHFcA=g@mail.gmail.com>
 <CACkq2mpduy_6g=jUmXjwAHciuc+wsw41C231fpaENfmfZMp8yQ@mail.gmail.com> <CACkq2mrVkfGfAO4WJJA5DJ+TW-nt_1JC2M4Q6MZb8bMe_k-gCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63412 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab2FFQYq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 12:24:46 -0400
Received: by dady13 with SMTP id y13so9004736dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 09:24:45 -0700 (PDT)
In-Reply-To: <CACkq2mrVkfGfAO4WJJA5DJ+TW-nt_1JC2M4Q6MZb8bMe_k-gCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org, sam.zaydel@inktank.com

On Wed, Jun 6, 2012 at 7:25 AM, Travis Rhoden <trhoden@gmail.com> wrote=
:
> Sorry for the re-post.=C2=A0 First attempt got eaten by the mailing l=
ist
> because it wasn't plain text.=C2=A0 My first attempt!
>
>> With CephFS not quite ready for production, what would be the recomm=
ended way for sharing Ceph to older operating systems?=C2=A0 Specifical=
ly, I want to share a file system (i.e. mount a common directory) on se=
veral CentOS5 and CentOS6 nodes.=C2=A0 I don't think I can mount an RBD=
 from more than one node, so what is my best bet?
>>
>> Mount an RBD on a file "head" and export it via NFS?
>>
>> I feel like that is the only sane choice, but wanted to ask in case =
I am missing something better.

Your other options are re-exporting NFS or CIFS, or trying to use ceph-=
fuse.

I recall using ceph-fuse on CentOS 6 personally and I've heard people
talk about ceph-fuse on CentOS 5, though we don't currently actively
test either. There, your biggest problem tends to be the 32-bit
limitation; ceph inodes are 64-bit, and ceph-fuse really wants to run
on a 64-bit machine.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
