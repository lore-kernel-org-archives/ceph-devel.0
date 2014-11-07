From: Giulio Fidente <gfidente@redhat.com>
Subject: Re: Ceph & Cinder & HA
Date: Fri, 07 Nov 2014 10:56:26 +0100
Message-ID: <545C974A.2090609@redhat.com>
References: <545B9A53.4040502@dachary.org> <DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com> <545C927E.9010807@redhat.com> <A6E8431B-9D66-4545-96A9-56E2C27AB9ED@iweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51876 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbaKGJ5h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Nov 2014 04:57:37 -0500
In-Reply-To: <A6E8431B-9D66-4545-96A9-56E2C27AB9ED@iweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Moreau Simard <dmsimard@iweb.com>
Cc: Loic Dachary <loic@dachary.org>, Florian Haas <florian.haas@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/07/2014 10:50 AM, David Moreau Simard wrote:
> Giulio,
>
> Right. The volume part is tricky because the volume is ultimately tied to one cinder-volume instance.
> I don't have a magic solution for that yet.

yep but this can be worked around by customizing the host= setting in 
Cinder so all instances of cinder-volume look like a single 'host'

this was discussed with Cinder guy here, which I am in touch with too, 
and is known to expose some issues due to multiple cinder-volume 
instances potentially trying to get access to the same volume when 
multiple tasks are queued ... yet this is 'known stuff' and they are 
already working on a 'state machine' for Cinder which will fix the a/a 
scenario

until then, the idea is to deploy cinder-volume in a a/p scenario, yet 
customizing the host= setting
-- 
Giulio Fidente
GPG KEY: 08D733BA | IRC: giulivo
