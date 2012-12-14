From: norbi <norbi@rocknob.de>
Subject: Re: litte bug in initscripts
Date: Fri, 14 Dec 2012 08:46:31 +0100
Message-ID: <50CAD957.9010401@rocknob.de>
References: <50CAD151.5080306@rocknob.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:41610 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab2LNHqe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 02:46:34 -0500
Received: from [80.67.16.214] (helo=[192.168.10.165])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <norbi@rocknob.de>)
	id 1TjPya-0002NY-0j
	for ceph-devel@vger.kernel.org; Fri, 14 Dec 2012 08:46:32 +0100
In-Reply-To: <50CAD151.5080306@rocknob.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hm...

now the MOD and MON doesn't start...

the problems seems the configuration differences in ceph.conf

http://ceph.com/docs/master/rados/configuration/ceph-conf/#the-ceph-conf-file

or its a failure in the documentation?

[osd.0]
         hostname = {hostname}

[mon.a]
         host = hostName
         mon addr = 150.140.130.120:6789

if i change "host = hostName" to "hostname = hostName" under "[mon.a]" i 
dont have to patch "ceph_common.sh"

On 14.12.2012 08:12, norbi wrote:
> Hi Ceph-List,
>
> i have found a little bug in "ceph_common.sh"
> "/usr/local/bin/ceph-conf --help" show the right option to get a
> hostname from the ceph.conf. in my case, the ceph init-script doesnt
> stop/start the OSDs
>
> FLAGS
>    --name name                     Set type.id
>
> or the example
>
> EXAMPLES
> $ ceph-conf --name mon.0 -c /etc/ceph/ceph.conf 'mon addr'
>
>
> Patchfile
>
> --- src/ceph_common.sh.old      2012-12-14 08:09:09.792952462 +0100
> +++ src/ceph_common.sh.new      2012-12-14 08:09:28.927956891 +0100
> @@ -33,7 +33,7 @@ verify_conf() {
>
>   check_host() {
>       # what host is this daemon assigned to?
> -    host=`$CCONF -c $conf -n $type.$id host`
> +    host=`$CCONF -c $conf --name $type.$id hostname`
>       if [ "$host" = "localhost" ]; then
>        echo "$0: use a proper short hostname (hostname -s), not
> 'localhost', in $conf section $type.$id; skipping entry"
>        return 1
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
