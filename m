From: James Page <james.page@ubuntu.com>
Subject: Re: 0.55 init script Issue?
Date: Wed, 05 Dec 2012 18:04:40 +0000
Message-ID: <50BF8CB8.5060708@ubuntu.com>
References: <50BF7314.2020809@gammacode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34244 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab2LESEo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 13:04:44 -0500
In-Reply-To: <50BF7314.2020809@gammacode.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mdawson@gammacode.com>
Cc: ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Mike

On 05/12/12 16:15, Mike Dawson wrote:
> After upgrading from 0.54 to 0.55, the command "service ceph
> start" fails. But "/etc/init.d/ceph start" works. This is the case
> for start. stop, etc. Here is an example:
> 
> root@node2:~# /etc/init.d/ceph stop === mon.a === Stopping Ceph
> mon.a on node2...kill 2505...done === osd.0 === Stopping Ceph osd.0
> on node2...kill 5042...done === osd.1 === Stopping Ceph osd.1 on
> node2...kill 5116...done === osd.17 === Stopping Ceph osd.17 on
> node2...kill 5275...done
> 
> 
> root@node2:~# service ceph start start: Job is already running:
> ceph
> 
> root@node2:~# /etc/init.d/ceph start === mon.a ===

I'd not noticed this either but it looks like there is both an upstart
configuration called 'ceph' (service ceph start) and an init script
called ceph (/etc/init.d/ceph start); this does not sound right to me
and I can't see what the ceph upstart configuration is actually doing
other than generating an event (which nothing is listening to).

The packages should ship one or the other IMHO.

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQv4y3AAoJEL/srsug59jDlnYP/AwOyWOSaScKFGiOnZHp7zpq
3QyKC4AGzIN7IH33kMJecu0diFaeJrlfZ/U6yv4jduVeUOpVf7ZUwma3d5WGOkg5
B1e5uTBYMabdZdZ2XnHRfChrDueMo4+Y+DinETeB8diL8xzP9vitCaAJxpavT5UQ
qKhO5ZwGSL9zWhtsN5QKc/qYv0ZbonUivMxKm+Imzgc6uuka7Z0JR+ETr9VJml4D
LOBM3dZKzF4ryPqpfeSGbI8W566qHm9MSIvBEcNNxUys+qjDMd/kLoP+SwYblD0H
sjDohj1xdnRIDf4y5FUh50HHl9Dy8NjGnA9X8bwDspiykNgU4kc2d6wHHpKMPMzA
6IywpifEZ9dD65Gbbqep8qQiXsjQDY/2V+c1RFDHripRg3AaXuPnZIxPGw7RevTJ
MMnYABVTT1jhfdpC0pzeIgdd5v55/1r30H4YyMV59pTIeuje6e+og2wXrhgky41N
fQl6tAY93cBV9/E5AjKtic/KpsYLSSU3BV/ivfUgHEb/UavX+wzGeBmZimrjSTZ0
8DUlpeJ9jBT5I+A6Y6u29HqKZFJuZo4AP8CXoRfhJrMfmn5Apu4zoB78raozKow9
JEERlL8SREXHIAREWbHO8Yk/RFkK9idpmQIh0/9FG0Ri76/Vyn1ayk44p7nzjTlZ
thcHGhvxsPEPFI+FWehI
=Lqnr
-----END PGP SIGNATURE-----
