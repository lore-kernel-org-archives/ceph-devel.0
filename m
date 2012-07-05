From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] Generate URL-safe base64 strings for keys.
Date: Thu, 5 Jul 2012 07:31:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207050729350.6931@cobra.newdream.net>
References: <CADvuQRERYhuFiz07Kp_YxOo_ya6-jACJ3X2gNihp=5F83BJQiQ@mail.gmail.com>
 <1341405987-26469-1-git-send-email-wido@widodh.nl>
 <Pine.LNX.4.64.1207040816350.6931@cobra.newdream.net>
 <1341418257.18922.2.camel@Nokia-N900-02-8> <Pine.LNX.4.64.1207040913420.6931@cobra.newdream.net>
 <4FF5974E.5070308@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51755 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab2GEObn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 10:31:43 -0400
In-Reply-To: <4FF5974E.5070308@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Thu, 5 Jul 2012, Wido den Hollander wrote:
> On 04-07-12 18:18, Sage Weil wrote:
> > On Wed, 4 Jul 2012, Wido den Hollander wrote:
> > > > On Wed, 4 Jul 2012, Wido den Hollander wrote:
> > > > > By using this we prevent scenarios where cephx keys are not accepted
> > > > > in various situations.
> > > > > 
> > > > > Replacing the + and / by - and _ we generate URL-safe base64 keys
> > > > > 
> > > > > Signed-off-by: Wido den Hollander <wido@widodh.nl>
> > > > 
> > > > Do already properly decode URL-sage base64 encoding?
> > > > 
> > > 
> > > Yes, it decodes URL-safe base64 as well.
> > > 
> > > See the if statements for 62 and 63, + and - are treated equally, just
> > > like / and _.
> > 
> > Oh, got it.  The commit description confused me... I thought this was
> > related encoding only.
> > 
> > I think we should break the encode and decode patches into separate
> > versions, and apply the decode to a stable branch (argonaut) and the
> > encode to the master.  That should avoid most problems with a
> > rolling/staggered upgrade...
> 
> I just submitted a patch for decoding only.

Applied, thanks!

> During some tests I did I found out that libvirt uses GNUlib and won't handle
> URL-safe base64 encoded keys.
> 
> So, as long as Ceph allows them we're good. Users can always replace the + and
> / in their key knowing it will be accepted by Ceph.
> 
> This works for me for now. The exact switch to base64url should be done at a
> later stage I think.
> 
> The RFC on this: http://tools.ietf.org/html/rfc4648#page-7

We could:
 - submit a patch for gnulib; someday it'll support it
 - kludge the secret generation code in ceph so that it rejects secrets 
   with problematic encoding... :/  (radosgw-admin does something 
   similar with +'s in the s3-style user keys.)

sage



> 
> Wido
> 
> > 
> > sage
> > 
> > 
> > > 
> > > Wido
> > > 
> > > 
> > > > sage
> > > > 
> > > > > ---
> > > > > src/common/armor.c |       6 +++---
> > > > > 1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/src/common/armor.c b/src/common/armor.c
> > > > > index d1d5664..7f73da1 100644
> > > > > --- a/src/common/armor.c
> > > > > +++ b/src/common/armor.c
> > > > > @@ -9,7 +9,7 @@
> > > > > * base64 encode/decode.
> > > > > */
> > > > > 
> > > > > -const char *pem_key =
> > > > > "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > > > > +const char *pem_key =
> > > > > "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
> > > > > 
> > > > > static int encode_bits(int c)
> > > > > {
> > > > > @@ -24,9 +24,9 @@ static int decode_bits(char c)
> > > > >          return c - 'a' + 26;
> > > > >      if (c >= '0' && c <= '9')
> > > > >          return c - '0' + 52;
> > > > > -    if (c == '+')
> > > > > +    if (c == '+' || c == '-')
> > > > >          return 62;
> > > > > -    if (c == '/')
> > > > > +    if (c == '/' || c == '_')
> > > > >          return 63;
> > > > >      if (c == '=')
> > > > >          return 0; /* just non-negative, please */
> > > > > --
> > > > > 1.7.9.5
> > > > > 
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > > > in the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at   http://vger.kernel.org/majordomo-info.html
> > > > > 
> > > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at   http://vger.kernel.org/majordomo-info.html
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
