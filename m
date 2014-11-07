From: David Moreau Simard <dmsimard@iweb.com>
Subject: Re: Ceph & Cinder & HA
Date: Fri, 7 Nov 2014 09:50:54 +0000
Message-ID: <A6E8431B-9D66-4545-96A9-56E2C27AB9ED@iweb.com>
References: <545B9A53.4040502@dachary.org>
 <DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com> <545C927E.9010807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmx1.iweb.com ([70.38.127.135]:38970 "EHLO bmx1.iweb.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbaKGJu6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Nov 2014 04:50:58 -0500
In-Reply-To: <545C927E.9010807@redhat.com>
Content-Language: en-US
Content-ID: <51999FC7100AC54F972F67CCB306F58B@corp.iweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Giulio Fidente <gfidente@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Florian Haas <florian.haas@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Giulio,

Right. The volume part is tricky because the volume is ultimately tied to one cinder-volume instance.
I don't have a magic solution for that yet.

I'm not going to the contributor summit unfortunately.

I'm not personally a fan of keepalived since I've been spoiled by corosync. Let's see if we can chat about this later.

--
David Moreau Simard

> On Nov 7, 2014, at 10:35 AM, Giulio Fidente <gfidente@redhat.com> wrote:
> 
> On 11/07/2014 09:46 AM, David Moreau Simard wrote:
>> Loic,
>> 
>> Was there an etherpad ? I'm curious as I didn't attend that one.
>> 
>> HA with Cinder mostly revolves around setting up multiple cinder-api and cinder-volume servers. Was there something else involved ?
>> I can probably contribute my knowledge on that..
> 
> hi David,
> 
> indeed it would be great if we could get in touch! I'm still at the summit, in the TripleO room, in case you are around too.
> 
> So yes there is an etherpad and also a TripleO spec which goes a bit more into the details (linked from the etherpad):
> 
> https://etherpad.openstack.org/p/tripleo-kilo-l3-and-cinder-ha
> 
> The architecture we're considering is as follows:
> 
>  keepalived
>    haproxy
>      ceph-mon
> 
> where haproxy and ceph-mon are always up on all openstack 'controller' nodes (also running cinder) and keepalived is taking care of managing a virtual ip hosted on one of those
> -- 
> Giulio Fidente
> GPG KEY: 08D733BA | IRC: giulivo

