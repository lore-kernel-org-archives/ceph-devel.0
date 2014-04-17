From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Re: Documentation Error - Manual Deployment - Monitor Bootstrapping
Date: Thu, 17 Apr 2014 15:23:30 -0500
Message-ID: <c1a23bdeb4a4ee5a7fb4e8aafcf648f2@localhost>
References: <2b647dfca2b13639319ace92a7a0b415@localhost>
Reply-To: YS3fpFE2ykfB@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([209.177.156.123]:58530 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbaDQUXb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Apr 2014 16:23:31 -0400
In-Reply-To: <2b647dfca2b13639319ace92a7a0b415@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com
Cc: ceph-devel@vger.kernel.org, ceph-devel-owner@vger.kernel.org

So after reading other documentation areas:

   http://ceph.com/docs/master/rados/configuration/mon-config-ref/
   http://ceph.com/docs/master/rados/configuration/ceph-conf/#monitors

I arrive at the following (working) config file:
-------
[global]
fsid = e3e1a87b-d282-41b5-b4ad-fb3f969e164f

[mon]
mon initial members = a

[mon.a]
host = cephmon
mon addr = 1.2.3.4:6789
-------



I also discovered that steps # 12 and # 13 are faulty.
  - In both steps, the {hostname} should actually be the monitors ID, not 
hostname.
  - So the correct commands are:
      sudo mkdir /var/lib/ceph/mon/{cluster-name}-{id}
      ceph-mon --mkfs -i {id} --monmap /tmp/monmap --keyring 
/tmp/ceph.mon.keyring



---
Thanks,
Dyweni

On 2014-04-17 14:52, Dyweni - Ceph-Devel wrote:
> Hi,
> 
> After following the directions
> (http://ceph.com/docs/master/install/manual-deployment/#monitor-bootstrapping)
> to manually deploy and bootstrap the monitor, I find that the init
> scripts will not start the ceph-mon process.
> 
> I am running Ceph 0.78, Gentoo Ebuild.
> 
> After completing step # 13, my /etc/ceph/ceph.conf file reads like 
> this:
> -------------
> [global]
> fsid = 6dcb9db5-b974-4164-83a0-381ea740a351
> mon initial members = cephmon
> mon host = 10.208.39.100
> -------------
> 
> When I try to start the monitor, nothing useful happens:
> ---------------
> # sh -x /usr/lib/ceph/ceph_init.sh start
> ++ dirname /usr/lib/ceph/ceph_init.sh
> + '[' /usr/lib/ceph = . ']'
> + BINDIR=/usr/bin
> + SBINDIR=/usr/sbin
> + LIBDIR=/usr/lib/ceph
> + ETCDIR=/etc/ceph
> + test -f /usr/lib/ceph/ceph_common.sh
> + . /usr/lib/ceph/ceph_common.sh
> ++ CCONF=/usr/bin/ceph-conf
> ++ default_conf=/etc/ceph/ceph.conf
> ++ conf=/etc/ceph/ceph.conf
> +++ hostname -s
> ++ hostname=cephmon
> + EXIT_STATUS=0
> + options=
> + version=0
> + dovalgrind=
> + docrun=
> + allhosts=0
> + debug=0
> + monaddr=
> + dofsmount=1
> + dofsumount=0
> + verbose=0
> + grep -q '^-'
> + echo start
> + verify_conf
> + '[' -x /etc/ceph/fetch_config ']'
> + '[' '!' -e /etc/ceph/ceph.conf ']'
> + command=start
> + '[' -n start ']'
> + shift
> + get_local_name_list
> + local=
> + get_local_daemon_list mon
> + type=mon
> + '[' -d /var/lib/ceph/mon ']'
> ++ find -L /var/lib/ceph/mon -mindepth 1 -maxdepth 1 -type d -printf 
> '%f\n'
> + for i in '`find -L /var/lib/ceph/$type -mindepth 1 -maxdepth 1 -type
> d -printf '\''%f\n'\''`'
> + '[' -e /var/lib/ceph/mon/ceph-cephmon/sysvinit ']'
> + get_local_daemon_list osd
> + type=osd
> + '[' -d /var/lib/ceph/osd ']'
> + get_local_daemon_list mds
> + type=mds
> + '[' -d /var/lib/ceph/mds ']'
> + get_name_list
> + orig=
> ++ egrep -v '^mon$'
> ++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -l mon
> ++ true
> ++ egrep -v '^mds$'
> ++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -l mds
> ++ true
> ++ egrep -v '^osd$'
> ++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -l osd
> ++ true
> + allconf=' '
> + '[' -z '' ']'
> + what=' '
> + return
> + '[' start = stop ']'
> + '[' start = start -a /usr/bin '!=' . ']'
> + '[' '' = '' ']'
> + ceph-disk activate-all
> + exit 0
> ---------------
> 
> 
> What am I missing here?
> 
> 
> 
> --
> Thanks,
> Dyweni
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
