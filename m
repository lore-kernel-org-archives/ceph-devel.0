From: Sage Weil <sage@newdream.net>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 10:12:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005250939440.8523@cobra.newdream.net>
References: <20100519192222.GD61706@ncolin.muc.de>
 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>
 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>
 <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>  <4BFA5D96.3030603@redhat.com>
  <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>  <4BFA696D.2060606@redhat.com>
  <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp>
 <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com>
 <4BFAD59E.2010706@codemonkey.ws> <4BFB94D9.5080904@redhat.com>
 <4BFBCDD9.4070104@codemonkey.ws> <4BFBCFB9.6020104@redhat.com>
 <4BFBD833.1030503@redhat.com> <4BFBF906.7010809@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60938 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab0EYRJR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 13:09:17 -0400
In-Reply-To: <4BFBF906.7010809@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>

On Tue, 25 May 2010, Avi Kivity wrote:
> > What's the reason for not having these drivers upstream? Do we gain
> > anything by hiding them from our users and requiring them to install the
> > drivers separately from somewhere else?
> >    
> 
> Six months.

FWIW, we (Ceph) aren't complaining about the 6 month lag time (and I don't 
think the Sheepdog guys are either).

From our perspective, the current BlockDriver abstraction is ideal, as it 
represents the reality of qemu's interaction with storage.  Any 'external' 
interface will be inferior to that in one way or another.  But either way, 
we are perfectly willing to work with you to all to keep in sync with any 
future BlockDriver API improvements.  It is worth our time investment even 
if the API is less stable.

The ability to dynamically load a shared object using the existing api 
would make development a bit easier, but I'm not convinced it's better for 
for users.  I think having ceph and sheepdog upstream with qemu will serve 
end users best, and we at least are willing to spend the time to help 
maintain that code in qemu.git.

sage
