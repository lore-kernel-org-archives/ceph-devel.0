From: Sage Weil <sage@inktank.com>
Subject: Re: Unique bug in ceph start script
Date: Mon, 22 Apr 2013 08:39:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304220836140.15710@cobra.newdream.net>
References: <20130422150612.GA22006@upset.ux.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33417 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab3DVPjD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 11:39:03 -0400
In-Reply-To: <20130422150612.GA22006@upset.ux.pdb.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Andreas,

On Mon, 22 Apr 2013, Andreas Friedrich wrote:
> Hallo,
> 
> I think I have found a bug in the ceph-0.56.4 start script concerning
> the following code section in src/init-ceph.in:
> 
> 212     if [ "$host" = "$hostname" ]; then
> 213         cur_conf=$conf
> 214     else
> 215         unique=`dd if=/dev/urandom bs=16 count=1 2>/dev/null | md5sum | awk '{print $1}'`
> 216         if echo $pushed_to | grep -v -q " $host "; then
> 217             scp -q $conf $host:/tmp/ceph.conf.$unique
> 218             trap "ssh $host rm /tmp/ceph.conf.$unique" EXIT
> 219             pushed_to="$pushed_to $host "
> 220         fi
> 221         cur_conf="/tmp/ceph.conf.$unique"
> 222     fi
> 223     cmd="$cmd -c $cur_conf"
> 
> Explanation:
> If there are more than one OSD instances configured for remote host
> "abc", the ceph configuration with a random file name will be copied
> to host "abc" and the pushed_to variable will be set. 
> 
> Next time, if there is another OSD instance for remote host "abc",
> the pushed_to variable is already set and therefore _no_ new ceph
> configuration file will be copied to host "abc". That's OK but
> nevertheless a new random file name will be created in line 215/221
> and will be used in line 223. This leads to an error because the
> new configuration file name is unknown on host "abc".

Thanks for the report!  I think this doesn't quite solve the problem, 
though.  If all the items for a given target are processed in order, then 
$unique will be correct, but if you get hosta, hostb, hosta then it will 
be wrong.

The simplist fix is probably to use a single $unique for the lifetime of 
the script, but this makes the filename predictable to a certain class of 
resourceful malicious users.  Alternatively, we chould only put a single 
remote target in $pushed_to and re-push the conf to a new temp file if we 
get the same host again out of order.

sage
