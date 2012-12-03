From: David Clarke <davidc@catalyst.net.nz>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Tue, 04 Dec 2012 09:59:55 +1300
Message-ID: <50BD12CB.3030506@catalyst.net.nz>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de> <50BCFA2F.9070603@inktank.com> <50BD0243.2050109@de-punkt.de> <50BD0E16.8090901@catalyst.net.nz> <50BD10A1.5020904@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:52178 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab2LCU77 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 15:59:59 -0500
In-Reply-To: <50BD10A1.5020904@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: Christopher Kunz <chrislist@de-punkt.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/12/12 09:50, Smart Weblications GmbH - Florian Wiessner wrote:
> Am 03.12.2012 21:39, schrieb David Clarke:
>> On 04/12/12 08:49, Christopher Kunz wrote:
>>> Am 03.12.12 20:14, schrieb Josh Durgin:
>>>> On 12/03/2012 11:05 AM, Oliver Francke wrote:
>> Also, if you're concerned about the time it takes to reboot a machine (sans fsck) then you
>> may want to consider using something like kexec (kexec-tools package in Debian/Ubuntu).
> 
>> http://en.wikipedia.org/wiki/Kexec
> 
> 
> Nice idea, but the website states "Kexec is currently available on the x86 32-bit platform
> only."

That has to be old information - we're using it in anger on 64 bit x86 machines, from both Intel
and AMD.  I have no idea about ARM etc, however.


- -- 
David Clarke
Systems Architect
Catalyst IT
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC9EsoACgkQRgFDJLQLJc2RUgCeNEV8vLYRq32Kvd8nzQw+sAKk
sbgAoIdfyuW53SEer1AVE/97+otdzn5b
=xHkx
-----END PGP SIGNATURE-----
