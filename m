From: Giulio Fidente <gfidente@redhat.com>
Subject: Re: Ceph & Cinder & HA
Date: Fri, 07 Nov 2014 10:35:58 +0100
Message-ID: <545C927E.9010807@redhat.com>
References: <545B9A53.4040502@dachary.org> <DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57669 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbaKGJhL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Nov 2014 04:37:11 -0500
In-Reply-To: <DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Moreau Simard <dmsimard@iweb.com>, Loic Dachary <loic@dachary.org>
Cc: Florian Haas <florian.haas@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/07/2014 09:46 AM, David Moreau Simard wrote:
> Loic,
>
> Was there an etherpad ? I'm curious as I didn't attend that one.
>
> HA with Cinder mostly revolves around setting up multiple cinder-api and cinder-volume servers. Was there something else involved ?
> I can probably contribute my knowledge on that..

hi David,

indeed it would be great if we could get in touch! I'm still at the 
summit, in the TripleO room, in case you are around too.

So yes there is an etherpad and also a TripleO spec which goes a bit 
more into the details (linked from the etherpad):

https://etherpad.openstack.org/p/tripleo-kilo-l3-and-cinder-ha

The architecture we're considering is as follows:

   keepalived
     haproxy
       ceph-mon

where haproxy and ceph-mon are always up on all openstack 'controller' 
nodes (also running cinder) and keepalived is taking care of managing a 
virtual ip hosted on one of those
-- 
Giulio Fidente
GPG KEY: 08D733BA | IRC: giulivo
