From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Documentation Error - Manual Deployment - Monitor Bootstrapping
Date: Wed, 23 Apr 2014 01:37:11 +0100
Message-ID: <53570B37.6050102@inktank.com>
References: <2b647dfca2b13639319ace92a7a0b415@localhost> <c1a23bdeb4a4ee5a7fb4e8aafcf648f2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:52183 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbaDWAhI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Apr 2014 20:37:08 -0400
Received: by mail-wg0-f52.google.com with SMTP id k14so177336wgh.11
        for <ceph-devel@vger.kernel.org>; Tue, 22 Apr 2014 17:37:06 -0700 (PDT)
In-Reply-To: <c1a23bdeb4a4ee5a7fb4e8aafcf648f2@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com
Cc: ceph-devel@vger.kernel.org

On 04/17/2014 09:23 PM, Dyweni - Ceph-Devel wrote:
> So after reading other documentation areas:
>
>    http://ceph.com/docs/master/rados/configuration/mon-config-ref/
>    http://ceph.com/docs/master/rados/configuration/ceph-conf/#monitors
>
> I arrive at the following (working) config file:
> -------
> [global]
> fsid = e3e1a87b-d282-41b5-b4ad-fb3f969e164f
>
> [mon]
> mon initial members = a
>
> [mon.a]
> host = cephmon
> mon addr = 1.2.3.4:6789
> -------
>
>
>
> I also discovered that steps # 12 and # 13 are faulty.
>   - In both steps, the {hostname} should actually be the monitors ID,
> not hostname.
>   - So the correct commands are:
>       sudo mkdir /var/lib/ceph/mon/{cluster-name}-{id}
>       ceph-mon --mkfs -i {id} --monmap /tmp/monmap --keyring
> /tmp/ceph.mon.keyring

Well, not really.

On the bullet list, just in beginning of the "Monitor Bootstrap" 
section, you may read:

"Monitor Name: Each monitor instance within a cluster has a unique name. 
In common practice, the Ceph Monitor name is the host name (we recommend 
one Ceph Monitor per host, and no commingling of Ceph OSD Daemons with 
Ceph Monitors). You may retrieve the short hostname with hostname -s."

So the guide will assume you actually follow this rule of thumb and is 
prepared with this in mind.  Other sections of the documentation will 
get into more detail on portions relevant to IDs and whatnot, but I 
don't think this guide was meant to tell you exactly everything about 
everything.  Should you follow the guide to the letter, you should not 
have any problems.

I don't really know how you got around to end up with 'mon.a' while 
following the guide, 'a' being the id of the mon.  But let's assume 
that's what you really want, in which case 'mon initial members = a' is 
correct.  'mon initial members' expects a list of all the monitors that 
are to be part of the initial quorum (or at least a majority of them).

During the guide, following the general rule of thumb of 'mon ID should 
be the hostname', you would end up with a monitor 'mon.cephmon' 
(assuming 'cephmon' as the host of your server, as per your config shown 
above) and 'mon initial members = cephmon'.

Should you for any reason have a problem while running the monitor after 
following the guide to the letter, please take a look into the logs and 
let us know.

   -Joao

>
>
> ---
> Thanks,
> Dyweni
>
> On 2014-04-17 14:52, Dyweni - Ceph-Devel wrote:
>> Hi,
>>
>> After following the directions
>> (http://ceph.com/docs/master/install/manual-deployment/#monitor-bootstrapping)
>>
>> to manually deploy and bootstrap the monitor, I find that the init
>> scripts will not start the ceph-mon process.
>>
>> I am running Ceph 0.78, Gentoo Ebuild.
>>
>> After completing step # 13, my /etc/ceph/ceph.conf file reads like this:
>> -------------
>> [global]
>> fsid = 6dcb9db5-b974-4164-83a0-381ea740a351
>> mon initial members = cephmon
>> mon host = 10.208.39.100
>> -------------
>>
>> When I try to start the monitor, nothing useful happens:
>> ---------------
>> # sh -x /usr/lib/ceph/ceph_init.sh start
>> ++ dirname /usr/lib/ceph/ceph_init.sh
>> + '[' /usr/lib/ceph = . ']'
>> + BINDIR=/usr/bin
>> + SBINDIR=/usr/sbin
>> + LIBDIR=/usr/lib/ceph
>> + ETCDIR=/etc/ceph
>> + test -f /usr/lib/ceph/ceph_common.sh
>> + . /usr/lib/ceph/ceph_common.sh
>> ++ CCONF=/usr/bin/ceph-conf
>> ++ default_conf=/etc/ceph/ceph.conf
>> ++ conf=/etc/ceph/ceph.conf
>> +++ hostname -s
>> ++ hostname=cephmon
>> + EXIT_STATUS=0
>> + options=
>> + version=0
>> + dovalgrind=
>> + docrun=
>> + allhosts=0
>> + debug=0
>> + monaddr=
>> + dofsmount=1
>> + dofsumount=0
>> + verbose=0
>> + grep -q '^-'
>> + echo start
>> + verify_conf
>> + '[' -x /etc/ceph/fetch_config ']'
>> + '[' '!' -e /etc/ceph/ceph.conf ']'
>> + command=start
>> + '[' -n start ']'
>> + shift
>> + get_local_name_list
>> + local=
>> + get_local_daemon_list mon
>> + type=mon
>> + '[' -d /var/lib/ceph/mon ']'
>> ++ find -L /var/lib/ceph/mon -mindepth 1 -maxdepth 1 -type d -printf
>> '%f\n'
>> + for i in '`find -L /var/lib/ceph/$type -mindepth 1 -maxdepth 1 -type
>> d -printf '\''%f\n'\''`'
>> + '[' -e /var/lib/ceph/mon/ceph-cephmon/sysvinit ']'
>> + get_local_daemon_list osd
>> + type=osd
>> + '[' -d /var/lib/ceph/osd ']'
>> + get_local_daemon_list mds
>> + type=mds
>> + '[' -d /var/lib/ceph/mds ']'
>> + get_name_list
>> + orig=
>> ++ egrep -v '^mon$'
>> ++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -l mon
>> ++ true
>> ++ egrep -v '^mds$'
>> ++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -l mds
>> ++ true
>> ++ egrep -v '^osd$'
>> ++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -l osd
>> ++ true
>> + allconf=' '
>> + '[' -z '' ']'
>> + what=' '
>> + return
>> + '[' start = stop ']'
>> + '[' start = start -a /usr/bin '!=' . ']'
>> + '[' '' = '' ']'
>> + ceph-disk activate-all
>> + exit 0
>> ---------------
>>
>>
>> What am I missing here?
>>
>>
>>
>> --
>> Thanks,
>> Dyweni
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
