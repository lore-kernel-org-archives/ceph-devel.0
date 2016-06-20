From: Sage Weil <sage@newdream.net>
Subject: Re: [GSoC] wrong patch "msg: change entity_addr_t encode/decode"
Date: Mon, 20 Jun 2016 17:47:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606201741410.21827@piezo.us.to>
References: <CAEG8a3JF2t1hkHY2MQK5DVwbOy3VGZUNuB-uF5mOzBSO8xhQeg@mail.gmail.com> <alpine.DEB.2.11.1606021238150.6221@cpach.fuggernut.com> <alpine.DEB.2.11.1606021343480.6221@cpach.fuggernut.com> <CAEG8a3+6YycUH6Hm6w3g_XeWPBfTYGf3KiNG0Ujw=FsPr+WaZQ@mail.gmail.com>
 <CAEG8a3Lwwe2htBbc=+D9hYn4SJnO04H83gKRqED0M4+fzpg+oQ@mail.gmail.com> <alpine.DEB.2.11.1606091205290.32559@cpach.fuggernut.com> <CAEG8a3KW+259oAWHVsRJOH2UK6skVHa-0-6C72xVt5F+Eh5Kyw@mail.gmail.com> <CAEG8a3KhOwMgZDfnbHyRsHwPrW8uDs4_8mmvU_73MVUzRQeRCA@mail.gmail.com>
 <alpine.DEB.2.11.1606101305530.6221@cpach.fuggernut.com> <CAEG8a3LSJFxGjoYHfZCRZHQ_bDw-jabRCgvsJntc+x6cjAMCPQ@mail.gmail.com> <alpine.DEB.2.11.1606151709370.26786@cpach.fuggernut.com> <CACJqLyb0pj4_JJuQ47PP0sRpGxb883ikEO31auYeDgFF7M97uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from batalion.com ([64.111.99.127]:35582 "EHLO localhost.localdomain"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756345AbcFTRsR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jun 2016 13:48:17 -0400
In-Reply-To: <CACJqLyb0pj4_JJuQ47PP0sRpGxb883ikEO31auYeDgFF7M97uQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Junwang Zhao <zhjwpku@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 16 Jun 2016, Haomai Wang wrote:
> On Thu, Jun 16, 2016 at 5:17 AM, Sage Weil <sage@newdream.net> wrote:
> >
> > I've rebased this and pushed a new wip-addrvec branch, PR
> >
> >         https://github.com/ceph/ceph/pull/9726
> >
> > I wonder if a good way to ease into using this would be to make
> > AsyncMessenger allow binding to multiple addresses (IPv4 and IPv6).
> >
> > Haomai, what do you think?
> >
> > That will help us fix the multiple-address issues in msg/async (for
> > example, announcing ourselves using the correct addr depending on which
> > socket we accepted the connection on).  That will be one less thing in the
> > way to making msg/async speak msgr2 on some connections.
> 
> Hmm, you mean in multi osd instance example, we need to make each osd
> instance own a bind address?
> 
> What's the problem if they use the same address, I guess the reason
> should be we have existing codes rely on this independent address
> potentially.

We assume the addrs are unique (hence the nonce) all over the place.

I wasn't thinking about the many-osds-in-one-process case, though.  A 
simpler step is to make a single process, single osd bind to both ipv4 and 
ipv6 addresses, and advertise both in the OSDMap.  (Then later we'll 
extent that to also have the legacy and msgr2 addrs.)

So msg/async will need to bind to multiple addrs, revise the get_myaddr 
interface to return a vector of addresses, and put that in the OSDMap.  
And when accepting a connection, we mark the Connection/Pipe to indicate 
which socket it connected on, and adjust the addr we advertise with 
the initial handshake accordingly.

I suspect there is a bunch of annoying cleanup around all things 
myaddr...

sage


> 
> >
> >
> > I started working on another branch that cleans up and refactors some of
> > the authentication callbacks from the msgr into osd/mds/mon code so that
> > we can accomodate both msgr1 and msgr2 authentication.
> >
> >         https://github.com/ceph/ceph/pull/9727
> >
> > A bit more cleanup still to do there, but soon I think we'll be to the
> > point where we need the msg/async half that implements the protocol so we
> > can wire the two together.
> 
> 
> ok...
> 
> >
> >
> > sage
> >
> >
> > On Sat, 11 Jun 2016, Junwang Zhao wrote:
> >
> > > Hi Sage,
> > >
> > > I have modified the patch to make it PASS the unittest, you may want
> > > to have a look and cherry-pick the updated commit[0].
> > >
> > > Thanks,
> > > Zhao
> > >
> > > [0] https://github.com/zhjwpku/ceph/commit/b1f1183e3e2f39bbdbfa326d0dfc6f9b95611321
> > >
> > > On Sat, Jun 11, 2016 at 1:07 AM, Sage Weil <sage@newdream.net> wrote:
> > > > On Fri, 10 Jun 2016, Junwang Zhao wrote:
> > > >> Hi Sage,
> > > >>
> > > >> Updated and pushed to another branch, see [0], the 'make check'
> > > >> shows that the test cases FAILS, could you tell me how to debug
> > > >> these unittest? I hope to see the result using "cout" but I don't know
> > > >> where those output goes to :(
> > > >>
> > > >> [0]https://github.com/zhjwpku/ceph/commit/e7307deae01fd6b675350fdae9c493eae04fdde9
> > > >
> > > > I fixed a problem in the messengesr that was breaking the addr learning,
> > > > and thus a bunch of the unit tests that try to run test clusters.  I also
> > > > rebased it on master.  Pushed an updated wip-addr-more to my git tree
> > > > (liewegas/ceph)!
> > > >
> > > > sage
> > > >
> > > >>
> > > >> Thanks,
> > > >> Zhao
> > > >>
> > > >> On Fri, Jun 10, 2016 at 10:37 AM, Junwang Zhao <zhjwpku@gmail.com> wrote:
> > > >> > Hi Sage,
> > > >> >
> > > >> > I have go a little bit further, the cases you mentioned really make sense,
> > > >> > please see [0] and make some comments, I am still not good at writting
> > > >> > the unittest.
> > > >> >
> > > >> > [0]https://github.com/zhjwpku/ceph/commit/4da16085a650f1dd0b743560836fdf213507d3b4
> > > >> >
> > > >> > Thanks!
> > > >> > Zhao
> > > >> >
> > > >> > On Fri, Jun 10, 2016 at 12:10 AM, Sage Weil <sage@newdream.net> wrote:
> > > >> >> On Wed, 8 Jun 2016, Junwang Zhao wrote:
> > > >> >>> Hi Sage,
> > > >> >>>
> > > >> >>> Write some unittest, but seems not right, see [0], give some comments
> > > >> >>> please, I use `cout` to print the value, but I don't know where to see them.
> > > >> >>>
> > > >> >>> I got a lot of other "FAIL" in the wip-addr-more branch, like:
> > > >> >>>   ceph-detect-init/run-tox.sh
> > > >> >>>   ceph-disk/run-tox.sh
> > > >> >>>   test/run-rbd-unit-tests.sh
> > > >> >>> I am wondering is this because my working environment? My laptop
> > > >> >>> is really not very powerful, "i5-3210M CPU, 8G memory" :(
> > > >> >>> make check is quite slow.
> > > >> >>>
> > > >> >>> [0] https://github.com/zhjwpku/ceph/commit/e15a240d56c2b67a8b0906dc80650a91bff1518f
> > > >> >>
> > > >> >> I'm traveling today and not able to replicate this yet--I'll take a look
> > > >> >> tomorrow.
> > > >> >>
> > > >> >> In the meantime, though, it doesn't look like your new tests are doing
> > > >> >> quite what I think we need them to.  I think the important cases are:
> > > >> >>
> > > >> >> 1- make sure that any encoded entity_addr_t can be decoded as a
> > > >> >> entity_addrvec_t, with size 1, where item 0 matches the addr.  Can use the
> > > >> >> existing arrays of addrs to parse to test this.
> > > >> >>
> > > >> >> 2- make sure that in all of those cases, if we encode the entity_addrvec_t
> > > >> >> with features 0, and decode as an entity_addr_t, we get back the same
> > > >> >> entity_addr_t.
> > > >> >>
> > > >> >> 3- the addrvec size > 1 cases:
> > > >> >>
> > > >> >> - populate an addrvec with multiple addrs where one is legacy and others
> > > >> >> are not, and ensure that encoding with features 0 and decoding as an addr
> > > >> >> gives back the legacy item.
> > > >> >>
> > > >> >> - multiple legacy addrs with features 0 should encode the first one in the
> > > >> >> list
> > > >> >>
> > > >> >> - a vec with all non-legacy addrs encoded with features 0 and decoded as
> > > >> >> addr should give back an addr that is not entity_addr_t() but is
> > > >> >> unusable/bogus.
> > > >> >>
> > > >> >> 4- the empty addrvec case:
> > > >> >>
> > > >> >> - encode with features 0 and decoding as addr should give back
> > > >> >> entity_addr_t().
> > > >> >>
> > > >> >> I think that's it?
> > > >> >>
> > > >> >> sage
> > > >> >>
> > > >> >>
> > > >> >>>
> > > >> >>> On Mon, Jun 6, 2016 at 4:28 PM, Junwang Zhao <zhjwpku@gmail.com> wrote:
> > > >> >>> > Hi, Sage,
> > > >> >>> >
> > > >> >>> > Sorry I did not see your reply util now, I will work on it.
> > > >> >>> >
> > > >> >>> > Thanks!
> > > >> >>> > Zhao
> > > >> >>> >
> > > >> >>> > On Fri, Jun 3, 2016 at 1:46 AM, Sage Weil <sage@newdream.net> wrote:
> > > >> >>> >> On Thu, 2 Jun 2016, Sage Weil wrote:
> > > >> >>> >>> Hi Zhao,
> > > >> >>> >>>
> > > >> >>> >>> On Tue, 31 May 2016, Junwang Zhao wrote:
> > > >> >>> >>> > Hi Sage & Haomai,
> > > >> >>> >>> >
> > > >> >>> >>> > I try to run './vstart.sh -d -x -n' to test the patches today, I got
> > > >> >>> >>> > some error like 'wrong node', after some work, I found the
> > > >> >>> >>> > error was introduced by this patch[0]. I change the code to
> > > >> >>> >>> > use the legacy decode and encode, but got stuck somewhere.
> > > >> >>> >>> >
> > > >> >>> >>> > --- a/src/msg/msg_types.h
> > > >> >>> >>> > +++ b/src/msg/msg_types.h
> > > >> >>> >>> > @@ -371,7 +371,7 @@ struct entity_addr_t {
> > > >> >>> >>> >    // broader study
> > > >> >>> >>> >
> > > >> >>> >>> >    void encode(bufferlist& bl, uint64_t features) const {
> > > >> >>> >>> > -    if ((features & CEPH_FEATURE_MSG_ADDR2) == 0) {
> > > >> >>> >>> > +    if ((features & CEPH_FEATURE_MSG_ADDR2) != 0) {
> > > >> >>> >>> >        ::encode((__u32)0, bl);
> > > >> >>> >>> >        ::encode(nonce, bl);
> > > >> >>> >>> >        sockaddr_storage ss = get_sockaddr_storage();
> > > >> >>> >>> >
> > > >> >>> >>> >
> > > >> >>> >>> > Can you please see the patch again and give some comments?
> > > >> >>> >>> >
> > > >> >>> >>> > [0]https://github.com/zhjwpku/ceph/commit/8934f038fdf28156038770e601e4a27f7a684390
> > > >> >>> >>>
> > > >> >>> >>> This was enough to make things work fo rme:
> > > >> >>> >>>
> > > >> >>> >>> diff --git a/src/msg/msg_types.h b/src/msg/msg_types.h
> > > >> >>> >>> index 9c521e6..0da0614 100644
> > > >> >>> >>> --- a/src/msg/msg_types.h
> > > >> >>> >>> +++ b/src/msg/msg_types.h
> > > >> >>> >>> @@ -199,8 +199,7 @@ WRITE_CLASS_ENCODER(ceph_sockaddr_storage)
> > > >> >>> >>>
> > > >> >>> >>>  struct entity_addr_t {
> > > >> >>> >>>    typedef enum {
> > > >> >>> >>> -    TYPE_NONE = 0,
> > > >> >>> >>> -    TYPE_LEGACY = 1,
> > > >> >>> >>> +    TYPE_LEGACY = 0,
> > > >> >>> >>>    } type_t;
> > > >> >>> >>>
> > > >> >>> >>>    __u32 type;
> > > >> >>> >>> @@ -211,7 +210,7 @@ struct entity_addr_t {
> > > >> >>> >>>      sockaddr_in6 sin6;
> > > >> >>> >>>    } u;
> > > >> >>> >>>
> > > >> >>> >>> -  entity_addr_t() : type(0), nonce(0) {
> > > >> >>> >>> +  entity_addr_t() : type(TYPE_LEGACY), nonce(0) {
> > > >> >>> >>>      memset(&u, 0, sizeof(u));
> > > >> >>> >>>    }
> > > >> >>> >>>    explicit entity_addr_t(const ceph_entity_addr &o) {
> > > >> >>> >>>
> > > >> >>> >>> but I think this is not the right fix.  I think we still want
> > > >> >>> >>> TYPE_NONE, TYPE_LEGACY, and (soon) TYPE_MSGR2, and that the core problem
> > > >> >>> >>> is places that are creating addrs aren't setting the type properly.  Going
> > > >> >>> >>> to play with this a bit...
> > > >> >>> >>
> > > >> >>> >> I pushed a wip-addr-more branch:
> > > >> >>> >>
> > > >> >>> >>         https://github.com/liewegas/ceph/commits/wip-addr-more
> > > >> >>> >>
> > > >> >>> >> This fixes the parser to take type prefixes, default to legacy, and
> > > >> >>> >> changes entity_addr_t() so that it renders are "-" instead of ":/0" (which
> > > >> >>> >> was weird anyway).
> > > >> >>> >>
> > > >> >>> >> I think what we need next are some unit tests in test/test_addrs.cc that
> > > >> >>> >> do things like encode a entity_addr_t with no features, decode as
> > > >> >>> >> entity_addrvec_t, or construct varous addrvecs, encode with no features,
> > > >> >>> >> an ensure a decode to entity_addr_t gives back the right addr from the
> > > >> >>> >> list.
> > > >> >>> >>
> > > >> >>> >> sage
> > > >> >>> --
> > > >> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > >> >>> the body of a message to majordomo@vger.kernel.org
> > > >> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >> >>>
> > > >> >>>
> > > >>
> > > >>
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
