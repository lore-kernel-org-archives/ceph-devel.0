From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: c++ build flags, clang++, -Wnomismatched-tags?
Date: Wed, 20 Jan 2016 18:07:31 -0500 (EST)
Message-ID: <1103317763.21365872.1453331251349.JavaMail.zimbra@redhat.com>
References: <1295550971.21353553.1453329599755.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1601201756390.18145@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:59927 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510AbcATXHc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jan 2016 18:07:32 -0500
In-Reply-To: <alpine.DEB.2.11.1601201756390.18145@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

My annoyance with this warning is that I don't really want to see "friend struct foo" decls, which seems vaguely bogus?  The warnings could be eliminated by using class everywhere and adding public specifier where expected--but we shouldn't have to do that...

Matt

----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, January 20, 2016 5:57:17 PM
> Subject: Re: c++ build flags, clang++, -Wnomismatched-tags?
> 
> On Wed, 20 Jan 2016, Matt Benjamin wrote:
> > Hi Ceph C++ devs,
> > 
> > I notice building with clang lots of warnings like:
> > 
> >       'SequencerPosition' defined as a struct here but previously declared
> >       as a
> >       class [-Wmismatched-tags]
> > struct SequencerPosition {
> > ^
> > /home/mbenjamin/dev/rgw/ceph-upstream/src/os/ObjectMap.h:24:1: note: did
> > you
> >       mean struct here?
> > class SequencerPosition;
> > ^~~~~
> > struct
> > 3 warnings generated.
> > 
> > induced by -Wmismatched-tags, which apparently clang++ has by default.  As
> > a ISO C++ developer, I don't think of "struct" as a token that can be
> > mismatched with "class" in friend or forward declaration, but clearly the
> > authors of this warning do.
> > 
> > I think my intuition would be to disable this warning.  What do others
> > think?
> 
> No arguments from me, although I wouldn't object to someone who wants to
> clean up the mismatches either.
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
