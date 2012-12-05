From: James Page <james.page@ubuntu.com>
Subject: Re: 0.55 init script Issue?
Date: Wed, 05 Dec 2012 20:17:41 +0000
Message-ID: <50BFABE5.1020904@ubuntu.com>
References: <50BF7314.2020809@gammacode.com> <50BFA354.7040308@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34745 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab2LEURp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 15:17:45 -0500
In-Reply-To: <50BFA354.7040308@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Mike Dawson <mdawson@gammacode.com>, ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 05/12/12 19:41, Dan Mick wrote:
> The story as best I know it is that we're trying to transition to
> and use upstart where possible, but that the upstart config does
> not (yet?) try to do what the init.d config did.  That is, it
> doesn't support options to the one script, but rather separates
> daemons into separate services, and does not reach out to remote
> machines to start daemons, etc.
> 
> The intent is that init.d/ceph is left for non-Upstart distros,
> AFAICT.
> 
> Tv had some design notes here:
> 
> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09314.html
>
>  We need better documentation/rationale here at least.

Maybe it might be better if the ceph init script and the ceph upstart
configuration did not namespace clash; how about shifting the name of
the ceph upstart configuration to ceph-all?



- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQv6vlAAoJEL/srsug59jDFO8P/jtC9TFAWLuFJoS/RC5nEwdO
x4OEdwYbRgE6ac5GK8ufMuqfonOVzDZ0jGxWzDrLSPQ3Ekow+E3wZFSgQN1ujhDT
0QeuAqseyMO++3Foe3HlcSAtp2IGr1VkgyLVNrnkn+rK/C8UOQnISeCvT30WFTEJ
xpr+DSiv2ZjH6fogb+p+fK7lD9anywR92pM65jNpPRnMaBZ49Rjbz8Xf3+yw8EHH
DkOvFjPnIw8pWc0FPfgbFOZNksOQ+UoIhsJJ2I5fVfLhsdcNjC+ETePi0W4VU7mL
FZLaUlGxgeDLCvgjXZ8fQ9T0sNJuYQ7H/4A0uLWnf3uNVMsE5MLff4msgAuotxle
l6w0lC+GzlHiRe6XRMgHwKq/Ifs/oZPgdGh5V6+zOERrZrl1+Z1EiD2MQkVzxk/M
7+06V/GlKLfv/hqrGOr1JtFI3AY+p+DJttq4+UN5HmxIFeaS19rSJxBxc7TqliH9
SiaoyhC6IBm8duEYHyuHfjnVksMNA/SOD4xyxGj/KLAS9IwvQhvOnaHfpQgMR7Bl
6zRyE+kisT3aC1UyvRiWCAg+8TzhQN46oMpE1JZQTJsbW2dtdXI/Jl8vDk+I8hX2
Qola8AzSHc80tp3p51PN+83V3iqHKvXeK8G36FnJm+tKufDPVe3WnE9ig5emRDez
it86WnE+jBLtA8QlZRm8
=XIJq
-----END PGP SIGNATURE-----
