From: Sage Weil <sweil@redhat.com>
Subject: Re: Encode/Decode new framework
Date: Fri, 9 Sep 2016 20:02:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609091957410.20211@piezo.us.to>
References: <BLUPR0201MB190892BDBE41A2AA7502EB9DE2F80@BLUPR0201MB1908.namprd02.prod.outlook.com> <alpine.DEB.2.11.1609072114580.32742@piezo.us.to> <alpine.DEB.2.11.1609081926450.10416@piezo.us.to>
 <CAN=+7FXp9nLT17Z6ve-OCMHLWS68rUB_5tPN03S-4oQcCjo0AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2110253994-1473451371=:20211"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755204AbcIIUDD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Sep 2016 16:03:03 -0400
In-Reply-To: <CAN=+7FXp9nLT17Z6ve-OCMHLWS68rUB_5tPN03S-4oQcCjo0AQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Varada Kari <Varada.Kari@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2110253994-1473451371=:20211
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Argh, so I thought I was on a roll until I ran up against a problem 
when adding traits for containers:

template<typename T, typename traits=denc_traits<T>>
struct denc_traits<std::list<T>> {
  enum { supported = traits::supported };
  enum { featured = traits::featured };
  enum { bounded = false };

  typename std::enable_if<!traits::bounded && !traits::featured>::type
    bound_encode(const std::list<T>& s, size_t& p) {
    p += sizeof(uint32_t);
    for (const T& e : s) {
      denc(e, p);
    }
  }
  ...

but I get a compile error on the denc_traits<std::list<T>> line:

/home/sage/src/ceph3/src/include/denc.h:181:8: error: default template 
arguments may not be used in partial specializations
 struct denc_traits<std::list<T>> {
        ^
/home/sage/src/ceph3/src/include/denc.h:181:8: error: template parameters 
not deducible in partial specialization:
/home/sage/src/ceph3/src/include/denc.h:181:8: note:         ‘traits’


I also tried a few variations on this:

template<typename T, typename traits=denc_traits<T>>
  struct denc_traits<std::list<T>,
		     typename std::enable_if<traits::supported>::type> {
  ...

but get the same error.

Basically, I'm not sure if/how we can pass in a custom traits for T to a 
container encode (e.g., list<T>). 

Any ideas?

Although honestly I'm not sure how useful/important that really is, so I'm 
just going to leave it off for now.

sage




On Thu, 8 Sep 2016, Samuel Just wrote:

> I went a bit further on
> https://github.com/athanatos/ceph/tree/wip-sam-enc-dec-proto
> 
> The branch now generates encdec free functions for every type with an
> enc_dec_traits instance.  Also, it automatically generates an
> enc_dec_traits instance for every type with encdec methods valid for
> all of the required argument types (like WRITE_CLASS_ENCODER currently
> does with types with encode and decode methods, but without actually
> needing the macro).  It also upgrades object_t to use the new way (by
> defining a single templated encdec method).  hobject_t is also
> partially converted -- still needs a strategy for ENCODE_START and
> friends.
> 
> The actual advantage of bothering with any of this that once hobject_t
> is converted, *all* types which encode vector<hobject_t> -- even using
> the old-style ::encode call -- automatically can estimate the total
> size and blast the whole vector into an unsafe_appender (or a char *).
> 
> There are a few issues:
> - Still need to figure out how to do conditional decoding with a
> single templated encdec method.
> - The single templated encdec method seems to make it impossible to
> make the encode variants const -- I'm probably missing a trick there
> (the branch currently just does a const_cast).
> 
> I do think all of this is orthogonal to Allen's stuff, so I'm really
> just trying to demonstrate that Allen's stuff can be extended to fit
> seamlessly in with the existing encoding stack.  That is, that all
> new-style types should also support ::encode/::decode, and that
> ::encode on an object composed entirely of new-style objects should be
> able to do an accelerated encoding so that we can update common
> critical-path data structures (vectors of common types, for example)
> without needing to update all users all the way up the stack at the
> same time.
> -Sam
> 
> On Thu, Sep 8, 2016 at 12:45 PM, Sage Weil <sweil@redhat.com> wrote:
> > Hey,
> >
> > I spent a bit of time looking at this today but quickly ran up against a
> > problem.  Maybe this is obvious, but I hadn't noticed yesterday. Sam's
> > original branch defines encode/decode functions like so:
> >
> > template<typename type, typename traits=enc_dec_traits<type> >
> > inline typename std::enable_if<traits::supported && !traits::feature>::type
> > encode(const type &v, bufferlist &bl, uint64_t features=0) {
> >   size_t size = traits::estimate(v);
> >   bufferlist::unsafe_appender app(&bl, size);
> >   traits::encode(v, app);
> > }
> >
> > This type of approach simply doesn't work if our overall goal is to do
> > *one* estimate for a complex encode (container of items, or big structure
> > that includes smaller ones), and then encode into a preallocated buffer.
> > At least it won't work if our encode functions are written in the usual
> > way like
> >
> >   void encode(bufferlist& bl) const {
> >     ::encode(member1, bl);
> >     ::encode(member2, bl);
> >   }
> >
> > because those encodes will re-invoke the above glue wrappers that do the
> > estimation.
> >
> > In order for this to work, I think a key requirement is that we have
> > "new-style" and "old-style" encode functions.  If any old-style code calls
> > an old-style encode() on a new-style object, we'll invoke a wrapper like
> > the above that does an estimation.  But new-style code has to invoke a
> > new-style encode for any nested structures.  (It simply doesn't make sense
> > for a new-style encode to encode an old-style object because it can't
> > calculate its size.)
> >
> > That means we need to define a new-style that is distinct.  I suggest
> > we just go with Allen's enc_dec scheme.  It's clearly distinct, and
> > it promises to be faster for both encode (char *'s passed around)
> > and decode.
> >
> > And then we explicitly disallow new-style enc_dec from encoding old-style
> > objects.
> >
> > Once we do that, I think the glue to make this work will be really simple:
> > invoke estimate, preallocate a buffer, and then invoke the new encode.
> >
> > I think the only trick is containers, where we'll need to define two
> > different versions: one for old-style encoders (the existing code with
> > enable_if and !supported guarding them) and one for new encoders.
> >
> > Given that, I think it makes the most sense to start with Allen and
> > Varada's original branch.  I'm going to give it a go...
> >
> > sage
> >
> >
> >
> >
> >
> > On Wed, 7 Sep 2016, Sage Weil wrote:
> >
> >> Hi Varada!
> >>
> >> On Wed, 7 Sep 2016, Varada Kari wrote:
> >> > Hi Sage,
> >> >
> >> > Here is the branch with some changes, not able to compile(yet!). Need to
> >> > write some more templates for STL(multimap etc...) and intrusive containers.
> >> >
> >> > https://github.com/varadakari/ceph/commits/wip-enc-dec-proto
> >> >
> >> > Right now i am facing some problem with encoding of MonMap with mon_addr
> >> > which is a map with string and entity_address_t. Have a written template
> >> > class for string which doesn't need any features. But this map needs a
> >> > features for address and not for string.
> >> > Trying to fix the problem. Please have a look. Correct me if i am going
> >> > in a wrong direction in the implementation(overall approach).
> >>
> >> I think teh way to address this is make sure that non-featured items have
> >> the uint64_t features = 0 argument defined for encode (as they do now).
> >> Then make the container declaration something like
> >>
> >> template<typename T, typename S>
> >> struct enc_dec_traits<
> >>   std::map<T, S>,
> >>   typename std::enable_if<
> >>     enc_dec_traits<T>::supported && enc_dec_traits<S>::feature &&
> >>     (enc_dec_traits<T>::feature || enc_dec_traits<S>::feature)>::type> {
> >>   const static bool supported = true;
> >>   const static bool feature = true;
> >>   ...
> >>
> >> and then make the encode methods pass through a feature argument.  I.e.,
> >> if either the key or the value requires featurse to encode, we require
> >> features to encode.
> >>
> >> Is that what you're asking?
> >>
> >> Alternatively, we can probably avoid specializing the template on
> >> featured/unfeatured at all, and in the enc_dec_traits just declare both a
> >> featured and unfeatured encode method.  The unfeatured one will error out
> >> at compile time if you call it on T or S types that require features.
> >>
> >> I haven't looked to closely at this branch, but it looks like the basic
> >> approach is:
> >>
> >>  - my appenders
> >>  - sam's branch that defines encode with templated App
> >>  - each object has encode, decode, and estimate
> >>  - STL containers are defined based on above
> >>
> >> but none of the enc_dec functions that let you write all three in one go.
> >> Are you thinking that that would be a separate, orthoganal thing, that
> >> lets you write a single enc_dec template function, and then use a macro to
> >> declare the encode/decode/estimate functions that call it, so that it all
> >> glues together?
> >>
> >> I'm still confused about what we are doing with the encode/decode/estimate
> >> members of the enc_dec_traits<> structures.  If we need a traits instance
> >> in order to encode/decode, that means we can't do the bare
> >>
> >>   ::encode(foo, bl);
> >>
> >> that we've been doing so far.  Unless there's some other template magic
> >> that instantiates the traits on demand?  Something like
> >>
> >> template<class T, class App>
> >> void encode(const T& a, App &app) {
> >>   enc_dec_traits<T> t;
> >>   t.encode(a, app);
> >> }
> >>
> >> ?
> >>
> >> Should we get on a bluejeans and walk through the possible paths here and
> >> pick an approach?  Because I'm pretty confused now by all the variations
> >> I've seen.
> >>
> >> sage
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-2110253994-1473451371=:20211--
