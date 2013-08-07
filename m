From: Sage Weil <sage@inktank.com>
Subject: RE: bug in /etc/init.d/ceph debian
Date: Wed, 7 Aug 2013 08:23:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308070822180.3006@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B62E7617E@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B62E82A96@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43767 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3HGPXx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Aug 2013 11:23:53 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B62E82A96@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

Here is a somewhat simpler patch; does this work for you?  Note that if 
you something like /etc/init.d/ceph status osd.123 where osd.123 isn't in 
ceph.conf then you get a status 1 instead of 3.  But for the 
/etc/init.d/ceph status mds (or osd or mon) case where there are no 
daemons of a particular type it works.

Perhaps the "does not exist" check should be also modified to return 3?

sage


diff --git a/src/init-ceph.in b/src/init-ceph.in
index 8eb02f8..be5565c 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -165,6 +165,12 @@ verify_conf
 command=$1
 [ -n "$*" ] && shift
 
+if [ "$command" = "status" ]; then
+    # nothing defined for this host => not running; we'll use this if we
+    # don't check anything below.
+    EXIT_STATUS=3
+fi
+
 get_local_name_list
 get_name_list "$@"
 


On Wed, 7 Aug 2013, James Harper wrote:

> > 
> > I'm running ceph 0.61.7-1~bpo70+1 and I think there is a bug in
> > /etc/init.d/ceph
> > 
> > The heartbeat RA expects that the init.d script will return 3 for "not running",
> > but if there is no agent (eg mds) defined for that host it will return 0 instead,
> > so pacemaker thinks the agent is running on a node where it isn't even
> > defined and presumably would then start doing stonith when it finds it
> > remains running after a stop command.
> > 
> > Or maybe that is the correct behaviour of the init.d script and the RA needs
> > to be modified?
> > 
> 
> Nobody interested in this?
> 
> My proposed fix follows this email. Return status is:
> 0 - everything tested is running
> 1 - something wrong
> 3 - something tested is stopped
> 
> Without this patch, the resource agents report that the service is running if the service is not defined on the host.
> 
> I'm not sure though if this is the right approach. Maybe the /etc/init.d/ceph should return 0 when checking the status of (say) mon, when there are no mons defined on this host?
> 
> James
> 
> --- ceph.orig   2013-08-07 13:28:25.000000000 +1000
> +++ ceph        2013-08-07 13:32:37.000000000 +1000
> @@ -170,6 +170,9 @@
>  get_local_name_list
>  get_name_list "$@"
> 
> +running=0
> +dead=0
> +stopped=0
>  for name in $what; do
>      type=`echo $name | cut -c 1-3`   # e.g. 'mon', if $item is 'mon1'
>      id=`echo $name | cut -c 4- | sed 's/^\\.//'`
> @@ -375,14 +378,15 @@
>             if daemon_is_running $name ceph-$type $id $pid_file; then
>                 echo -n "$name: running "
>                 do_cmd "$BINDIR/ceph --admin-daemon $asok version 2>/dev/null" || echo unknown
> +                running=1
>              elif [ -e "$pid_file" ]; then
>                  # daemon is dead, but pid file still exists
>                  echo "$name: dead."
> -                EXIT_STATUS=1
> +                dead=1
>              else
>                  # daemon is dead, and pid file is gone
>                  echo "$name: not running."
> -                EXIT_STATUS=3
> +                stopped=1
>              fi
>             ;;
> 
> @@ -430,6 +434,16 @@
>      esac
>  done
> 
> +if [ "$command" = "status" ]; then
> +    if [ "$dead" = "1" ]; then
> +      EXIT_STATUS=1
> +    elif [ "$running" = "1" ]; then
> +      EXIT_STATUS=0
> +    else
> +      EXIT_STATUS=3
> +    fi
> +fi
> +
>  # activate latent osds?
>  if [ "$command" = "start" ]; then
>      if [ "$*" = "" ] || echo $* | grep -q ^osd\$ ; then
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
