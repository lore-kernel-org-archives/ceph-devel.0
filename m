From: Sage Weil <sweil@redhat.com>
Subject: RE: question about the 'r' value in CRUSH
Date: Mon, 25 Jan 2016 08:24:42 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601250822370.6524@cpach.fuggernut.com>
References: <FF8D83DAE5DF57468726B79904321E0603CA9DE5@H3CMLB12-EX.srv.huawei-3com.com> <alpine.DEB.2.11.1601240933230.5707@cpach.fuggernut.com> <FF8D83DAE5DF57468726B79904321E0603CAA06E@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1413929772-1453728284=:6524"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbcAYNYc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jan 2016 08:24:32 -0500
In-Reply-To: <FF8D83DAE5DF57468726B79904321E0603CAA06E@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1413929772-1453728284=:6524
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 25 Jan 2016, Xusangdi wrote:
> In normal scenario, this behavior is not that outstanding, but it does exist. Please see below:
> 
> $ crushtool -o crushmap --build --num_osds 12 host straw2 3 root straw2 0
> $ crushtool -i crushmap --test --x 0 --num-rep 3 --show-mappings --weight 0 0
[...]

The retries are normal.  You just need to leave choose_tries to a large 
enough value (default is now 50, I believe) so that you always get a full 
sized result.  It is a problem if you have a very small set of potentially 
suitable results, though (as with your 3-item tree with skewed weights, or 
perhaps a larger tree but with most of the OSDs marked 'out').

sage



> CRUSHCHOOSE_LEAF bucket -5 x 0 outpos 0 numrep 3 tries 51 recurse_tries 1 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -5 x=0 r=0
>   item -1 type 1
> CHOOSE bucket -1 x 0 outpos 0 numrep 1 tries 1 recurse_tries 0 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -1 x=0 r=0
>   item 0 type 0
>   reject 1  collide 0  ftotal 1  flocal 1
> skip rep
> CHOOSE returns 0
>   reject 1  collide 0  ftotal 1  flocal 1
>  crush_bucket_choose -5 x=0 r=1
>   item -4 type 1
> CHOOSE bucket -4 x 0 outpos 0 numrep 1 tries 1 recurse_tries 0 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -4 x=0 r=0
>   item 11 type 0
> CHOOSE got 11
> CHOOSE returns 1
> CHOOSE got -4
>  crush_bucket_choose -5 x=0 r=1 <== redundant try
>   item -4 type 1
>   reject 0  collide 1  ftotal 1  flocal 1
>  crush_bucket_choose -5 x=0 r=2
>   item -4 type 1
>   reject 0  collide 1  ftotal 2  flocal 1
>  crush_bucket_choose -5 x=0 r=3
>   item -2 type 1
> CHOOSE bucket -2 x 0 outpos 1 numrep 2 tries 1 recurse_tries 0 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -2 x=0 r=1
>   item 5 type 0
> CHOOSE got 5
> CHOOSE returns 2
> CHOOSE got -2
>  crush_bucket_choose -5 x=0 r=2 <== redundant try
>   item -4 type 1
>   reject 0  collide 1  ftotal 1  flocal 1
>  crush_bucket_choose -5 x=0 r=3 <== redundant try
>   item -2 type 1
>   reject 0  collide 1  ftotal 2  flocal 1
>  crush_bucket_choose -5 x=0 r=4
>   item -2 type 1
>   reject 0  collide 1  ftotal 3  flocal 1
>  crush_bucket_choose -5 x=0 r=5
>   item -1 type 1
> CHOOSE bucket -1 x 0 outpos 2 numrep 3 tries 1 recurse_tries 0 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -1 x=0 r=2
>   item 0 type 0
>   reject 1  collide 0  ftotal 1  flocal 1
> skip rep
> CHOOSE returns 2
>   reject 1  collide 0  ftotal 4  flocal 1
>  crush_bucket_choose -5 x=0 r=6
>   item -4 type 1
>   reject 0  collide 1  ftotal 5  flocal 1
>  crush_bucket_choose -5 x=0 r=7
>   item -4 type 1
>   reject 0  collide 1  ftotal 6  flocal 1
>  crush_bucket_choose -5 x=0 r=8
>   item -2 type 1
>   reject 0  collide 1  ftotal 7  flocal 1
>  crush_bucket_choose -5 x=0 r=9
>   item -4 type 1
>   reject 0  collide 1  ftotal 8  flocal 1
>  crush_bucket_choose -5 x=0 r=10
>   item -3 type 1
> CHOOSE bucket -3 x 0 outpos 2 numrep 3 tries 1 recurse_tries 0 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -3 x=0 r=2
>   item 7 type 0
> CHOOSE got 7
> CHOOSE returns 3
> CHOOSE got -3
> CHOOSE returns 3
>  rule 0 x 0 [11,5,7]
> 
> - - - - - - - - - - - - - - - - - - - -
> Sangdi Xu
> UIS 2, Team BORE
> 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Sunday, January 24, 2016 10:35 PM
> > To: xusangdi 11976 (RD)
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: question about the 'r' value in CRUSH
> >
> > On Sat, 23 Jan 2016, Xusangdi wrote:
> > > Hi Sage,
> > >
> > > Recently we encountered an interesting case when learning about CRUSH, please see below:
> > >
> > > root root {
> > >     id -4       # do not change unnecessarily
> > >     # weight 36.000
> > >     alg straw2
> > >     hash 0  # rjenkins1
> > >     item host0 weight 3.000
> > >     item host1 weight 3.000
> > >     item host2 weight 30.000
> > > }
> > >
> > > CRUSHCHOOSE_LEAF bucket -4 x 3 outpos 0 numrep 3 tries 51
> > > recurse_tries 1 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0  crush_bucket_choose -4
> > x=3 r=0
> > >   item -3 type 1
> > > CHOOSE bucket -3 x 3 outpos 0 numrep 1 tries 1 recurse_tries 0
> > > local_retries 0 local_fallback_retries 0 parent_r 0 stable 0  crush_bucket_choose -3 x=3 r=0
> > >   item 8 type 0
> > > CHOOSE got 8
> > > CHOOSE returns 1
> > > CHOOSE got -3
> > >  crush_bucket_choose -4 x=3 r=1
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 1  flocal 1  crush_bucket_choose -4 x=3
> > > r=2
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 2  flocal 1  crush_bucket_choose -4 x=3
> > > r=3
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 3  flocal 1  crush_bucket_choose -4 x=3
> > > r=4
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 4  flocal 1  crush_bucket_choose -4 x=3
> > > r=5
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 5  flocal 1  crush_bucket_choose -4 x=3
> > > r=6
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 6  flocal 1  crush_bucket_choose -4 x=3
> > > r=7
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 7  flocal 1  crush_bucket_choose -4 x=3
> > > r=8
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 8  flocal 1  crush_bucket_choose -4 x=3
> > > r=9
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 9  flocal 1  crush_bucket_choose -4 x=3
> > > r=10
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 10  flocal 1  crush_bucket_choose -4 x=3
> > > r=11
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 11  flocal 1  crush_bucket_choose -4 x=3
> > > r=12
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 12  flocal 1  crush_bucket_choose -4 x=3
> > > r=13
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 13  flocal 1  crush_bucket_choose -4 x=3
> > > r=14
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 14  flocal 1  crush_bucket_choose -4 x=3
> > > r=15
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 15  flocal 1  crush_bucket_choose -4 x=3
> > > r=16
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 16  flocal 1  crush_bucket_choose -4 x=3
> > > r=17
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 17  flocal 1  crush_bucket_choose -4 x=3
> > > r=18
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 18  flocal 1  crush_bucket_choose -4 x=3
> > > r=19
> > >   item -2 type 1
> > > CHOOSE bucket -2 x 3 outpos 1 numrep 2 tries 1 recurse_tries 0
> > > local_retries 0 local_fallback_retries 0 parent_r 0 stable 0  crush_bucket_choose -2 x=3 r=1
> > >   item 4 type 0
> > > CHOOSE got 4
> > > CHOOSE returns 2
> > > CHOOSE got -2
> > >  crush_bucket_choose -4 x=3 r=2
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 1  flocal 1  crush_bucket_choose -4 x=3
> > > r=3
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 2  flocal 1  crush_bucket_choose -4 x=3
> > > r=4
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 3  flocal 1  crush_bucket_choose -4 x=3
> > > r=5
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 4  flocal 1  crush_bucket_choose -4 x=3
> > > r=6
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 5  flocal 1  crush_bucket_choose -4 x=3
> > > r=7
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 6  flocal 1  crush_bucket_choose -4 x=3
> > > r=8
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 7  flocal 1  crush_bucket_choose -4 x=3
> > > r=9
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 8  flocal 1  crush_bucket_choose -4 x=3
> > > r=10
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 9  flocal 1  crush_bucket_choose -4 x=3
> > > r=11
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 10  flocal 1  crush_bucket_choose -4 x=3
> > > r=12
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 11  flocal 1  crush_bucket_choose -4 x=3
> > > r=13
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 12  flocal 1  crush_bucket_choose -4 x=3
> > > r=14
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 13  flocal 1  crush_bucket_choose -4 x=3
> > > r=15
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 14  flocal 1  crush_bucket_choose -4 x=3
> > > r=16
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 15  flocal 1  crush_bucket_choose -4 x=3
> > > r=17
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 16  flocal 1  crush_bucket_choose -4 x=3
> > > r=18
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 17  flocal 1  crush_bucket_choose -4 x=3
> > > r=19
> > >   item -2 type 1
> > >   reject 0  collide 1  ftotal 18  flocal 1  crush_bucket_choose -4 x=3
> > > r=20
> > >   item -2 type 1
> > >   reject 0  collide 1  ftotal 19  flocal 1  crush_bucket_choose -4 x=3
> > > r=21
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 20  flocal 1  crush_bucket_choose -4 x=3
> > > r=22
> > >   item -3 type 1
> > >   reject 0  collide 1  ftotal 21  flocal 1  crush_bucket_choose -4 x=3
> > > r=23
> > >   item -1 type 1
> > > CHOOSE bucket -1 x 3 outpos 2 numrep 3 tries 1 recurse_tries 0
> > > local_retries 0 local_fallback_retries 0 parent_r 0 stable 0  crush_bucket_choose -1 x=3 r=2
> > >   item 0 type 0
> > > CHOOSE got 0
> > > CHOOSE returns 3
> > > CHOOSE got -1
> > > CHOOSE returns 3
> > >  rule 0 x 3 [8,4,0]
> > >
> > > It looks that when choosing the third replica, we repeat a lot of tries which have already tried for the
> > second one.
> > > Is this intended or maybe an issue?
> >
> > It's because one bucket is weighted so much more heavily than the others.
> > You're asking for something that's somewhat impossible: 3 replicas coming from 3 items with different
> > weights.  Since we're sampling, if the weights are too skewed you'll run out of tries (r values) and it'll
> > give up with only 2 results.
> >
> > sage
> -------------------------------------------------------------------------------------------------------------------------------------
> 本邮件及其附件含有杭州华三通信技术有限公司的保密信息，仅限于发送给上面地址中列出
> 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
> 或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
> 邮件！
> This e-mail and its attachments contain confidential information from H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-1413929772-1453728284=:6524--
