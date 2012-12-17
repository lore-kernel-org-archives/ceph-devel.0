From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: litte bug in initscripts
Date: Mon, 17 Dec 2012 08:34:25 -0800
Message-ID: <50CF4991.5010304@inktank.com>
References: <50CAD151.5080306@rocknob.de> <50CAD957.9010401@rocknob.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42691 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab2LQQe2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 11:34:28 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4128475pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 08:34:27 -0800 (PST)
In-Reply-To: <50CAD957.9010401@rocknob.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: norbi <norbi@rocknob.de>
Cc: ceph-devel@vger.kernel.org

On 12/13/2012 11:46 PM, norbi wrote:
> hm...
>
> now the MOD and MON doesn't start...
>
> the problems seems the configuration differences in ceph.conf
>
> http://ceph.com/docs/master/rados/configuration/ceph-conf/#the-ceph-conf-file
>
>
> or its a failure in the documentation?

It's a type in the docs, which is now fixed.
It should be host = {hostname} for all sections.

Josh

> [osd.0]
>          hostname = {hostname}
>
> [mon.a]
>          host = hostName
>          mon addr = 150.140.130.120:6789
>
> if i change "host = hostName" to "hostname = hostName" under "[mon.a]" i
> dont have to patch "ceph_common.sh"
>
> On 14.12.2012 08:12, norbi wrote:
>> Hi Ceph-List,
>>
>> i have found a little bug in "ceph_common.sh"
>> "/usr/local/bin/ceph-conf --help" show the right option to get a
>> hostname from the ceph.conf. in my case, the ceph init-script doesnt
>> stop/start the OSDs
>>
>> FLAGS
>>    --name name                     Set type.id
>>
>> or the example
>>
>> EXAMPLES
>> $ ceph-conf --name mon.0 -c /etc/ceph/ceph.conf 'mon addr'
>>
>>
>> Patchfile
>>
>> --- src/ceph_common.sh.old      2012-12-14 08:09:09.792952462 +0100
>> +++ src/ceph_common.sh.new      2012-12-14 08:09:28.927956891 +0100
>> @@ -33,7 +33,7 @@ verify_conf() {
>>
>>   check_host() {
>>       # what host is this daemon assigned to?
>> -    host=`$CCONF -c $conf -n $type.$id host`
>> +    host=`$CCONF -c $conf --name $type.$id hostname`
>>       if [ "$host" = "localhost" ]; then
>>        echo "$0: use a proper short hostname (hostname -s), not
>> 'localhost', in $conf section $type.$id; skipping entry"
>>        return 1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

