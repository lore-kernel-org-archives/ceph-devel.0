From: David Disseldorp <ddiss@suse.de>
Subject: Re: GPG signing of upstream release tags
Date: Wed, 5 Jul 2017 14:09:47 +0200
Message-ID: <20170705140947.657bc67e@suse.de>
References: <20170209160345.1cf38e78@suse.de>
        <87inojxfzp.fsf@suse.com>
        <CALqRxCxW3EfmGqZNBXfUoDjLLMecsEcDNKRAHOv3pa=ry8Mp=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36855 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751637AbdGEMJt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Jul 2017 08:09:49 -0400
In-Reply-To: <CALqRxCxW3EfmGqZNBXfUoDjLLMecsEcDNKRAHOv3pa=ry8Mp=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Abhishek L <abhishek@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Thu, 9 Feb 2017 21:42:55 -0700, Ken Dreyer wrote:

> On Thu, Feb 9, 2017 at 1:32 PM, Abhishek L <abhishek@suse.com> wrote:
> > Since v11.0.0/v10.0.5/v0.94.3,  
> >> these tags have not been GPG signed, so downstream consumers have no
> >> reliable way of verifying that the source they have matches the reviewed
> >> and tested upstream release source.  
> 
> The old ceph.com GPG key had been copied to too many places, including
> some of the Jenkins slaves, which was bad. Today there is a central
> signer box behind a firewall with very restricted access.
> 
> I'll talk with Andrew and Alfredo about GPG signing Git tags and
> source tarballs going forward, because I think we can script something
> here to make it easier. I agree that it's important.

Any updates here? I notice that the Luminous tags are still missing GPG
signatures. My preference would be to have the signing done explicitly
by someone involved in the upstream release, using their own personal
keys, rather than using an automated signer box.

Cheers, David
