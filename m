From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: LSB Requires-Start: ... $network ... vs
	network.service
Date: Wed, 03 Jul 2013 14:52:28 +0100
Message-ID: <51D42C9C.4040304@colin.guthr.ie>
References: <alpine.DEB.2.00.1307022001130.31293@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <alpine.DEB.2.00.1307022001130.31293@cobra.newdream.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>,
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>,
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Errors-To: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, systemd-devel@lists.freedesktop.org
List-Id: ceph-devel.vger.kernel.org

'Twas brillig, and Sage Weil at 03/07/13 04:06 did gyre and gimble:
> Hi everyone,
> 
> I have a sysvinit script on fedora 18 (systemd 195) with
> 
>  ### BEGIN INIT INFO
>  # Provides:          ceph
>  # Default-Start:     2 3 4 5
>  # Default-Stop:      0 1 6
>  # Required-Start:    $remote_fs $named $network $time
>  # Required-Stop:     $remote_fs $named $network $time
>  # Short-Description: Start Ceph distributed file system daemons at boot  time
>  # Description:       Enable Ceph distributed file system services.
>  ### END INIT INFO
> 
> and my daemon keeps failing on startup to bind to it's ip:port.  I 
> modified the script to dump systemctl -a output and I see
> 
>  network.service           loaded inactive   dead            LSB: Bring up/down networking
>  NetworkM...online.service loaded inactive   dead            Network Manager Wait Online
>  NetworkManager.service    loaded active     running         Network Manager
> 
> I know next to nothing about systemd (or Fedora, for that matter), but I 
> would expect the $network bit in Required-Start to make the job wait for 
> network.service. 

Almost, but not quite!

Anything prefixed with a $ in LSB headers doesn't refer to a single
service, but rather a collection of services all working towareds
providing that. Some LSB headers may have "Provides: $network" for
example. In systemd, this concept is generally translated to "targets"
and thus $network actually corresponds to network.target in systemd, not
network.service.

More info here:

http://www.freedesktop.org/wiki/Software/systemd/NetworkTarget/


In your setup (from the output above) it looks like network.service is
actually disabled and you're using NetworkManager.service instead to
initialise your network.

When this happens network.target will be complete pretty much at the
same moment that NetworkManager has finished starting. This is because
network.target doesn't have any built in knowledge of when a network is
considered "up" (see the link above for several examples of what
different people may consider "up").

In order to actually wait for your network to be up, you need to enable
the NetworkManager-wait-online.service. This will then delay the point
at which network.target becomes started until after that service exits.
This should cause your network dependant service to be started later and
you'll be happy!

Of course this doesn't help when the network disappears and comes back
later, so the *real* solution here is to patch ceph to be aware of the
rtnetlink events. It then doesn't have any solid dep on a fairly loosely
defined and unreliable "point in time" when the network is ready and
remains available forever more!

Hope that helps.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
