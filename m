From: Sage Weil <sweil@redhat.com>
Subject: Re: Encode/Decode new framework
Date: Wed, 7 Sep 2016 21:29:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609072114580.32742@piezo.us.to>
References: <BLUPR0201MB190892BDBE41A2AA7502EB9DE2F80@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752047AbcIGV3l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Sep 2016 17:29:41 -0400
In-Reply-To: <BLUPR0201MB190892BDBE41A2AA7502EB9DE2F80@BLUPR0201MB1908.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>, sjust@redhat.com
Cc: ceph-devel@vger.kernel.org

Hi Varada!

On Wed, 7 Sep 2016, Varada Kari wrote:
> Hi Sage,
> 
> Here is the branch with some changes, not able to compile(yet!). Need to
> write some more templates for STL(multimap etc...) and intrusive containers.
> 
> https://github.com/varadakari/ceph/commits/wip-enc-dec-proto
> 
> Right now i am facing some problem with encoding of MonMap with mon_addr
> which is a map with string and entity_address_t. Have a written template
> class for string which doesn't need any features. But this map needs a
> features for address and not for string.
> Trying to fix the problem. Please have a look. Correct me if i am going
> in a wrong direction in the implementation(overall approach).

I think teh way to address this is make sure that non-featured items have 
the uint64_t features = 0 argument defined for encode (as they do now). 
Then make the container declaration something like

template<typename T, typename S>
struct enc_dec_traits<
  std::map<T, S>,
  typename std::enable_if<
    enc_dec_traits<T>::supported && enc_dec_traits<S>::feature &&
    (enc_dec_traits<T>::feature || enc_dec_traits<S>::feature)>::type> {
  const static bool supported = true;
  const static bool feature = true;
  ...

and then make the encode methods pass through a feature argument.  I.e., 
if either the key or the value requires featurse to encode, we require 
features to encode.

Is that what you're asking?

Alternatively, we can probably avoid specializing the template on 
featured/unfeatured at all, and in the enc_dec_traits just declare both a 
featured and unfeatured encode method.  The unfeatured one will error out 
at compile time if you call it on T or S types that require features.

I haven't looked to closely at this branch, but it looks like the basic 
approach is:

 - my appenders
 - sam's branch that defines encode with templated App
 - each object has encode, decode, and estimate
 - STL containers are defined based on above

but none of the enc_dec functions that let you write all three in one go.  
Are you thinking that that would be a separate, orthoganal thing, that 
lets you write a single enc_dec template function, and then use a macro to 
declare the encode/decode/estimate functions that call it, so that it all 
glues together?

I'm still confused about what we are doing with the encode/decode/estimate 
members of the enc_dec_traits<> structures.  If we need a traits instance 
in order to encode/decode, that means we can't do the bare

  ::encode(foo, bl);

that we've been doing so far.  Unless there's some other template magic 
that instantiates the traits on demand?  Something like

template<class T, class App>
void encode(const T& a, App &app) {
  enc_dec_traits<T> t;
  t.encode(a, app);
}

?

Should we get on a bluejeans and walk through the possible paths here and 
pick an approach?  Because I'm pretty confused now by all the variations 
I've seen.

sage
