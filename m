From: David Clarke <davidc@catalyst.net.nz>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Tue, 04 Dec 2012 09:39:50 +1300
Message-ID: <50BD0E16.8090901@catalyst.net.nz>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de> <50BCFA2F.9070603@inktank.com> <50BD0243.2050109@de-punkt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:51128 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab2LCUq6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 15:46:58 -0500
In-Reply-To: <50BD0243.2050109@de-punkt.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher Kunz <chrislist@de-punkt.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/12/12 08:49, Christopher Kunz wrote:
> Am 03.12.12 20:14, schrieb Josh Durgin:
>> On 12/03/2012 11:05 AM, Oliver Francke wrote:
>>> Hi *,
>>> 
>>> well, even if 0.48.2 is really stable and reliable, it is not everytime the case with linux
>>> kernel. We have a couple of nodes, where an update would make life better. So, as our
>>> OSD-nodes have to care for VM's too, it's not the problem to let them drain so migrate all
>>> of them to other nodes. Just reboot? Perhaps not, cause all OSD's will begin to 
>>> remap/backfill, they are instructed to do so. Well, declare them as "osd lost"? Dangerous.
>>> Is there another way I miss in doing node-maintenance? Will we have to wait for bobtail for
>>> far less hassle with all remapping and resources?
>> 
>> By default the monitors won't mark an OSD out in the time it takes to reboot, but if
>> maintenance takes longer, you can drain data from the node.
> Hi,
> 
> what time is that (in seconds) and how can we reliably test this?

I believe that the time out you're referring to is:

'mon osd down out interval', which defaults to 300 seconds.

http://ceph.com/docs/master/rados/configuration/mon-config-ref/

Also, if you're concerned about the time it takes to reboot a machine (sans fsck) then you may
want to consider using something like kexec (kexec-tools package in Debian/Ubuntu).

http://en.wikipedia.org/wiki/Kexec


- -- 
David Clarke
Systems Architect
Catalyst IT
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC9DhYACgkQRgFDJLQLJc3X2gCcDfk0rXLUXL90R4rYGNyFFLXE
hoAAnRkAMoSNc/27o6R4IGcLDX6u7Mpe
=/2TX
-----END PGP SIGNATURE-----
