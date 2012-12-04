From: David Clarke <davidc@catalyst.net.nz>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Wed, 05 Dec 2012 10:31:03 +1300
Message-ID: <50BE6B97.1050808@catalyst.net.nz>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de> <50BCFA2F.9070603@inktank.com> <50BD0243.2050109@de-punkt.de> <50BD0E16.8090901@catalyst.net.nz> <50BD10A1.5020904@smart-weblications.de> <50BD12CB.3030506@catalyst.net.nz> <50BDD1D7.3030904@de-punkt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:44117 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab2LDVbI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 16:31:08 -0500
In-Reply-To: <50BDD1D7.3030904@de-punkt.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher Kunz <chrislist@de-punkt.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/12/12 23:35, Christopher Kunz wrote:
> Hey,
>> That has to be old information - we're using it in anger on 64 bit x86 machines, from both
>> Intel and AMD.  I have no idea about ARM etc, however.
> just to make absolutely sure: Are you using kexec "in anger" to switch Ceph nodes to new
> kernels? I'm very doubtful that the approach will work seamlessly with Ceph, as it is rather
> picky regarding kernel state...

The normal shutdown cycle is activated, and Ceph on that node is stopped.  However, at the end of
the rc.6 scripts is one to, instead of rebooting, exec a new kernel and then progress as normal
through the boot process, and Ceph started again.

Haven't encountered any major issues thus far.


- -- 
David Clarke
Systems Architect
Catalyst IT
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC+a5cACgkQRgFDJLQLJc2SOwCeKCc9aV1z09acvA3vOIMjHpJ1
F5wAn32idJCPe4WNcu0smSNzUSZv634F
=JBvD
-----END PGP SIGNATURE-----
