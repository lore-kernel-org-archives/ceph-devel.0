From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: [BUG]  ceph 0.23 ,sudo /etc/init.d/init-ceph  cleanalllogs ,
 delete /   folder
Date: Thu, 2 Dec 2010 15:25:40 +0800
Message-ID: <1291274740.1757.85.camel@cephhost>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:3001 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757259Ab0LBHY1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 02:24:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sage@newdream.net" <sage@newdream.net>, "gregf@hq.newdream.net" <gregf@hq.newdream.net>, "yehuda@hq.newdream.net" <yehuda@hq.newdream.net>, "colinm@hq.newdream.net" <colinm@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org, mllv <mllv@tnsoft.com.cn>, wchen <wchen@tnsoft.com.cn>

Hi , 

We refer to ceph wiki :
http://ceph.newdream.net/wiki/Starting_and_stopping

,use the commands:
start|stop -- start or stop the daemon(s)
forcestop  -- force stop (kill -9)
killall    -- kill all instance of daemon type on the host (useful is
pid file is wrong or missing)
cleanlogs  -- clean out log directory
cleanalllogs -- clean out _everything_ from log directory


If we execute the command : "init-ceph cleanalllogs" , which will
delete / folder (logs,see below ):

================================================
1. cleanalllogs

$ sudo /etc/init.d/init-ceph cleanalllogs
=== mon.0 === 
removing all logs
rm: cannot remove `/var/log/ceph/stat': Is a directory
rm: cannot remove `/bin': Is a directory
rm: cannot remove `/boot': Is a directory
rm: cannot remove `/cdrom': Is a directory
rm: cannot remove `/dev': Is a directory
rm: cannot remove `/etc': Is a directory
rm: cannot remove `/home': Is a directory
rm: cannot remove `/lib': Is a directory
rm: cannot remove `/lost+found': Is 
rm: cannot remove `/media': Is a directory
rm: cannot remove `/mnt': Is a directory
rm: cannot remove `/opt': Is a directory
rm: cannot remove `/proc': Is a directory
rm: cannot remove `/root': Is a directory
rm: cannot remove `/sbin': Is a directory
rm: cannot remove `/selinux': Is a directory
rm: cannot remove `/srv': Is a directory
rm: cannot remove `/sys': Is a directory
rm: cannot remove `/tmp': Is a directory
rm: cannot remove `/usr': Is a directory
rm: cannot remove `/var': Is a directory
/etc/init.d/init-ceph: 1: cut: not found
/etc/init.d/init-ceph: 1: cut: not found
/etc/init.d/init-ceph: 1: sed: not found
/etc/init.d/init-ceph: 1: /usr/local/bin/cconf: not found
/etc/init.d/init-ceph: 1: /usr/local/bin/cconf: not found
/etc/init.d/init-ceph: 1: /usr/local/bin/cconf: not found
=== . === 
/etc/init.d/init-ceph: 1: /usr/local/bin/cconf: not found
/etc/init.d/init-ceph: 1: /usr/local/bin/cconf: not found
/etc/init.d/init-ceph: 1: /usr/local/bin/cconf: not found
/etc/init.d/init-ceph: 1: grep: not found
/etc/init.d/init-ceph: 1: /usr/local/bin/cconf: not found
/etc/init.d/init-ceph: 1: dirname: not found
removing all logs
/etc/init.d/init-ceph: 1: whoami: not found
/etc/init.d/init-ceph: 1: bash: not found

=========================================================

2.init-ceph script
	.................................
	.................................

        force-reload | reload)
            signal_daemon $name c$type $pid_file -1 "Reloading"
            ;;

        restart)
            $0 $options stop $name
            $0 $options start $name
            ;;

        cleanlogs)
            echo removing logs
            do_cmd "for f in $log_sym_dir/$name*; do rm -f \`readlink \
$f\` ; rm -f \$f ; done"
            ;;

        cleanalllogs)
            echo removing all logs
            do_cmd "rm -f $log_dir/* $log_sym_dir/* || true"
            ;;

        *)
            usage_exit
            ;;
    esac
done

exit 0

 =================================================        

Look into init-ceph codes, should be "$log_sym_dir/* " equal to  "/*",
"cleanlogs" command also exist this issue. init-ceph script might be add
a check for "$log_dir" and "$log_sym_dir".

and If we detect some of bugs ,does it update to 
http://tracker.newdream.net/projects/ceph ?

if yes ,how ?

thanks.
Jeff,wu










