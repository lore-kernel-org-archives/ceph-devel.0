From: Sage Weil <sage@newdream.net>
Subject: Re: [GSoC] wrong patch "msg: change entity_addr_t encode/decode"
Date: Thu, 2 Jun 2016 13:46:20 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606021343480.6221@cpach.fuggernut.com>
References: <CAEG8a3JF2t1hkHY2MQK5DVwbOy3VGZUNuB-uF5mOzBSO8xhQeg@mail.gmail.com> <alpine.DEB.2.11.1606021238150.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46310 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbcFBRp5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 13:45:57 -0400
In-Reply-To: <alpine.DEB.2.11.1606021238150.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Junwang Zhao <zhjwpku@gmail.com>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 2 Jun 2016, Sage Weil wrote:
> Hi Zhao,
> 
> On Tue, 31 May 2016, Junwang Zhao wrote:
> > Hi Sage & Haomai,
> > 
> > I try to run './vstart.sh -d -x -n' to test the patches today, I got
> > some error like 'wrong node', after some work, I found the
> > error was introduced by this patch[0]. I change the code to
> > use the legacy decode and encode, but got stuck somewhere.
> > 
> > --- a/src/msg/msg_types.h
> > +++ b/src/msg/msg_types.h
> > @@ -371,7 +371,7 @@ struct entity_addr_t {
> >    // broader study
> > 
> >    void encode(bufferlist& bl, uint64_t features) const {
> > -    if ((features & CEPH_FEATURE_MSG_ADDR2) == 0) {
> > +    if ((features & CEPH_FEATURE_MSG_ADDR2) != 0) {
> >        ::encode((__u32)0, bl);
> >        ::encode(nonce, bl);
> >        sockaddr_storage ss = get_sockaddr_storage();
> > 
> > 
> > Can you please see the patch again and give some comments?
> > 
> > [0]https://github.com/zhjwpku/ceph/commit/8934f038fdf28156038770e601e4a27f7a684390
> 
> This was enough to make things work fo rme:
> 
> diff --git a/src/msg/msg_types.h b/src/msg/msg_types.h
> index 9c521e6..0da0614 100644
> --- a/src/msg/msg_types.h
> +++ b/src/msg/msg_types.h
> @@ -199,8 +199,7 @@ WRITE_CLASS_ENCODER(ceph_sockaddr_storage)
>  
>  struct entity_addr_t {
>    typedef enum {
> -    TYPE_NONE = 0,
> -    TYPE_LEGACY = 1,
> +    TYPE_LEGACY = 0,
>    } type_t;
>  
>    __u32 type;
> @@ -211,7 +210,7 @@ struct entity_addr_t {
>      sockaddr_in6 sin6;
>    } u;
>  
> -  entity_addr_t() : type(0), nonce(0) { 
> +  entity_addr_t() : type(TYPE_LEGACY), nonce(0) {
>      memset(&u, 0, sizeof(u));
>    }
>    explicit entity_addr_t(const ceph_entity_addr &o) {
> 
> but I think this is not the right fix.  I think we still want 
> TYPE_NONE, TYPE_LEGACY, and (soon) TYPE_MSGR2, and that the core problem 
> is places that are creating addrs aren't setting the type properly.  Going 
> to play with this a bit...

I pushed a wip-addr-more branch:

	https://github.com/liewegas/ceph/commits/wip-addr-more

This fixes the parser to take type prefixes, default to legacy, and 
changes entity_addr_t() so that it renders are "-" instead of ":/0" (which 
was weird anyway).

I think what we need next are some unit tests in test/test_addrs.cc that 
do things like encode a entity_addr_t with no features, decode as 
entity_addrvec_t, or construct varous addrvecs, encode with no features, 
an ensure a decode to entity_addr_t gives back the right addr from the 
list.

sage
