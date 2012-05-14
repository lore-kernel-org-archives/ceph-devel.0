From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 16:04:45 -0700
Message-ID: <5133CDAC-FC95-4330-897A-A8BB63F3166F@cs.ucsc.edu>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu> <CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com> <FC7D87FB-20FE-400E-959D-7C3FC558A89B@cs.ucsc.edu> <Pine.LNX.4.64.1205141034001.20330@cobra.newdream.net> <6DA7B347-76E2-4D6D-9ABA-42BF973F8AAC@cs.ucsc.edu> <CAPYLRzgn_cwk6LfYgZbC5FvBbph9z6HGh_qyveHBr3CFOocs8w@mail.gmail.com> <CAPYLRzgBa8Ucoqase5jQU_a8SrW0DtaZozp2ckDT5a0=Y6FoGQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:54910 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758203Ab2ENXEq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 19:04:46 -0400
In-Reply-To: <CAPYLRzgBa8Ucoqase5jQU_a8SrW0DtaZozp2ckDT5a0=Y6FoGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org


On May 14, 2012, at 1:57 PM, Gregory Farnum wrote:

> On Mon, May 14, 2012 at 10:49 AM, Gregory Farnum <greg@inktank.com> w=
rote:
>> I haven't had the chance to go over everything thoroughly (I notice =
a
>> few other users of EDOM that I want to check out), but those
>> definitely sound better to me.
>> More better review comments later today.
>> -Greg
>=20
> After reviewing, I do have one other note, and that's on the use of
> errno. Most of Ceph avoids errno; it's only set in 19 places in the
> code and a lot of those don't count. However, we seem to have run int=
o
> a need for it (readdir), and this patchset has both rewinddir and
> seekdir returning under error conditions without doing any
> notification. So I think both of those functions (and any I missed)
> need to set errno if they bail out =97 the other possibility is
> converting them to have a return code, which I'm not opposed to but i=
s
> another user-visible change.

In contrast to readdir, the seek/rewinddir man pages state that these f=
unctions do not return an error (via errno or otherwise). So, presumabl=
y a client assuming man-page-ish semantics would never check errno afte=
r seekdir, which could have odd implications for arbitrary code just tr=
ying to tie into libcephfs. Then again, maybe they should use libcephfs=
 man pages :) ?

- Noah--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
