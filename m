From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: new boost
Date: Fri, 26 Aug 2016 22:26:06 +0200
Message-ID: <eee5fce8-59c7-38a3-1e98-05877a8e7c08@digiware.nl>
References: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:19917 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755654AbcH1Ry6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 28 Aug 2016 13:54:58 -0400
In-Reply-To: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 26-8-2016 20:42, Sage Weil wrote:
> Now that we've transitioned to cmake, I'd like to resurrect the discussion 
> about moving to a new version of boost.  I'm dying to use small_vector and 
> flat_map.
> 
> IIRC, we have a few options:
> 
> 1) boost as a submodule.  compile and link statically.
>  - easy to maintain
>  - no packaging impact
>  - dev/build environment is not dependent on system install boost
> 
> 2) build and package newer boost, build packages, and distribute with 
> ceph.
>  - distro folks won't lose their hats
>  - bunch of packaging work
>  - bunch of release repo building work (to ensure proper packages get 
> included)
>  - dev environments are awkward (need new boost installed on the system)
> 
> 3) combination of 1 and 2
>  - all of the work of 1 and 2
>  - plus, extra cmake options to use either static or dynamic version
> 
> 4) #1, with cmake smarts to let you choose the submodule or installed 
> boost (and possibly autoselect system boost if it's new enough).
> 
> I'm prety firmly in the #1/#4 camp because I don't think that #2 brings 
> any benefits that aren't political.  The main reason to use shared 
> libraries is because distros/users can update it independently to fix bugs 
> or (more importantly) security flaws.  However, in the case of boost, 
> almost all of it exists in header code and is compiled statically, so the 
> likelihood that a bug might be found that can be fixed by recompiling the 
> dynamically linked portion is basically zero.
> 
> And it's a ton of extra work to build and distribute the shared libraries.

If anything I'd be in #1. And after the dust has settled, and there is a
big urge to actually make things dynamic only then do the extra Cmake work.

The FreeBSD package is at 1.55, and the steps forward are hard to sync
with any external event. So I'd prefer to not have to watch my back for
a boost-train hitting me from behind.

--WjW


