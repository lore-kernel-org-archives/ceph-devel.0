From: Owen Synge <osynge@suse.com>
Subject: Re: systemd and ceph.conf and environment variables. (particularly
 mds and rgw)
Date: Mon, 7 Mar 2016 13:37:36 +0100
Message-ID: <56DD7610.2040403@suse.com>
References: <56DD5B26.30902@suse.com>
 <alpine.DEB.2.11.1603070641150.25897@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38997 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbcCGMhu (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 7 Mar 2016 07:37:50 -0500
In-Reply-To: <alpine.DEB.2.11.1603070641150.25897@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 03/07/2016 12:47 PM, Sage Weil wrote:
> On Mon, 7 Mar 2016, Owen Synge wrote:
>> Dear all,
>>
>> I have a simple idea that I think would be beneficial for ceph's
>> services. I would be curious to hear others opinions.
>>
>> At the moment the only way (I know) to configure specific entities i=
n
>> ceph such as a specific port for a mds or rgw is via ${CLUSTERNAME}.=
conf
>> which is usually set to ceph.conf. For brevity I will call this file
>> ceph.conf.
>=20
> In jewel there is a new path added to the config search path:=20
> /var/lib/ceph/$type/$cluster-$id/config.  This is checked before=20
> /etc/ceph/$cluster.conf, which means that you have to put *all* confi=
g=20
> values in the new location if you use it, but it might capture your=20
> use-case?

It does capture it nearly 100%.

While it does capture my usecase I still suggest we go further and have
all variables for an entity able to come from its own local environment=
,
rather than just sections in the config search.

The (current list of) reasons:

(1) environment variables are easier to pass in systemd format than a
ceph.conf file for cluster management tools.

(2) We can support much richer overloading and defaulting with
environment variables. Allowing for example defaulting cluster name as
"ceph" and overriding it on a per module basis, this can be extended to
other variables.

This said, since your solution does cover most of the test cases
(excluding cluster name) The importance of this change is greatly reduc=
ed.

> If you need both config paths to work, one idea is to add 'include <p=
ath>'=20
> support to the conf parser... hoping to avoid making things more=20
> complicated if we don't have a strong reason for it, though!

Thanks for the hint, I dont feel this is needed yet, and would rather
avoid complications caused by such an idea unless I had too.


>> The current setup leads to complexities as ideally I want all ceph.c=
onf
>> files to be identical across a cluster, and at the same time, I want=
 to
>> add services such as rgw or mds without changing ceph.conf. I also w=
ant
>> to template a ceph.conf cluster.
>>
>> If we could always get these settings via environment variables, it
>> would make setting up ceph with tools such as cluster/config managem=
ent
>> tools such as puppet, chef, and salt easier.
>>
>> So here is the diff of the systemd service files I am thinking of:
>>
>> # diff -u  ceph-mds@.service /tmp/ceph-mds@.service
>> --- ceph-mds@.service   2016-03-01 20:48:05.000000000 -0500
>> +++ /tmp/ceph-mds@.service      2016-03-07 05:14:43.392000000 -0500
>> @@ -8,8 +8,8 @@
>>  LimitNOFILE=3D1048576
>>  LimitNPROC=3D1048576
>>  EnvironmentFile=3D-/etc/sysconfig/ceph
>> -Environment=3DCLUSTER=3Dceph
>> -ExecStart=3D/usr/bin/ceph-mds -f --cluster ${CLUSTER} --id %i --set=
user
>> ceph --setgroup ceph
>> +EnvironmentFile=3D-/var/lib/ceph/env/mds/%i
>> +ExecStart=3D/usr/bin/ceph-mds -f --cluster ${CLUSTER} --id %i --set=
user
>> ceph --setgroup ceph -m ${BIND_IPV4}:${BIND_PORT}
>>  ExecReload=3D/bin/kill -HUP $MAINPID
>>  PrivateDevices=3Dyes
>>  ProtectHome=3Dtrue
>>
>> First you should note the extra EnvironmentFile line:
>>
>> EnvironmentFile=3D-/var/lib/ceph/mds/systemd/%i
>>
>> This means that if the mds service is started with parameter "param_=
one"
>> then the environment will be set with the content of
>>
>>     /var/lib/ceph/env/mds/param_one
>>
>> The "-" means don=E2=80=99t error if the above file does not exist.
>>
>> Hence we could add service instance variables such as ${BIND_IPV4} a=
nd
>> ${BIND_PORT} as well as important values like ${CLUSTER} to values l=
ike
>> ceph.
>>
>> Having played with systemd, it seems that environment variables are
>> updated by the last assignment in systemd just like shell.
>>
>> I have *not* found a good way to put in conditionals in such systemd
>> "EnvironmentFile" content. Hence it would be impossible to nicely
>> default command line parameters without using dirty tricks. Specific=
ally
>> what we cant do in the systemd "EnvironmentFile" context:
>>
>> 	if [ X"${BIND_IPV4}${BIND_PORT}" !=3D X ] ; then
>> 	EXTRA_ARGS=3D"-m ${BIND_IPV4}:${BIND_PORT}"
>> 	fi
>>
>> Hence I think we have to accept to integrate with systemd nicely we
>> should allow setting to be read from environment rather than only fr=
om
>> the command line.
>>
>> What do people think?
>=20
> I would probably make it '/var/lib/ceph/$type/$cluster-$id/env'.
>=20
> You're sure systemd lets you specify multiple environment files?

Many examples of doing this are available.

Also I tested it and it worked on Friday on SUSE LEAP for my simple tes=
t
case. We have more cases I could test though.

>  We
> can't/shouldn't stop looking at the standard location...

Totally agree.

Best regards

Owen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
