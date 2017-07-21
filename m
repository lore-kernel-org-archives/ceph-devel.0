From: Sage Weil <sage@newdream.net>
Subject: Re: external key mgr for ceph-mon?
Date: Fri, 21 Jul 2017 19:13:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707211911160.27271@piezo.novalocal>
References: <CAGbviv+mBMnDo_R81btpw-1jM_5m0ihW5GGJ_uYB7DksT1xKjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48846 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754141AbdGUTNj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jul 2017 15:13:39 -0400
In-Reply-To: <CAGbviv+mBMnDo_R81btpw-1jM_5m0ihW5GGJ_uYB7DksT1xKjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Wyllys,

On Fri, 21 Jul 2017, Wyllys Ingersoll wrote:
> Has anyone considered making the ceph-mon process fetch an external
> "master" wrapping key from an external server (preferably using KMIP
> protocol) to wrap/unwrap the ceph keys used for OSD encryption (or
> possibly other keys as well)?
> 
> In certain environments, there are strict requirements to have
> external key management for disk-encryption keys. Now that keys for
> OSD encryption are stored in the monitor, it should be possible to
> wrap those keys in the monitor persistent storage with an external key
> so that they system could not be started without fetching the master
> wrapping key from an external source.
> 
> I just wanted to check and see if anyone has done any work in this area.

This isn't currently possible.  It could be done but would probably 
require some inelegant changes to the config-key service.  However, the 
dmcrypt key management was written to be modular so that some other key 
management service could be used instead of the mons.  This should only 
require some hacking on the ceph-disk code that creates and stores these 
keys during prepare and fetches them on activate.

Note that there is also some early work on integrating with kerberos, but 
that doesn't address the dmcrypt key management at all.

sage
