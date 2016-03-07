From: Owen Synge <osynge@suse.com>
Subject: systemd and ceph.conf and environment variables. (particularly mds
 and rgw)
Date: Mon, 7 Mar 2016 11:42:46 +0100
Message-ID: <56DD5B26.30902@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:59199 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbcCGKmu (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 7 Mar 2016 05:42:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Dear all,

I have a simple idea that I think would be beneficial for ceph's
services. I would be curious to hear others opinions.

At the moment the only way (I know) to configure specific entities in
ceph such as a specific port for a mds or rgw is via ${CLUSTERNAME}.con=
f
which is usually set to ceph.conf. For brevity I will call this file
ceph.conf.

The current setup leads to complexities as ideally I want all ceph.conf
files to be identical across a cluster, and at the same time, I want to
add services such as rgw or mds without changing ceph.conf. I also want
to template a ceph.conf cluster.

If we could always get these settings via environment variables, it
would make setting up ceph with tools such as cluster/config management
tools such as puppet, chef, and salt easier.

So here is the diff of the systemd service files I am thinking of:

# diff -u  ceph-mds@.service /tmp/ceph-mds@.service
--- ceph-mds@.service   2016-03-01 20:48:05.000000000 -0500
+++ /tmp/ceph-mds@.service      2016-03-07 05:14:43.392000000 -0500
@@ -8,8 +8,8 @@
 LimitNOFILE=3D1048576
 LimitNPROC=3D1048576
 EnvironmentFile=3D-/etc/sysconfig/ceph
-Environment=3DCLUSTER=3Dceph
-ExecStart=3D/usr/bin/ceph-mds -f --cluster ${CLUSTER} --id %i --setuse=
r
ceph --setgroup ceph
+EnvironmentFile=3D-/var/lib/ceph/env/mds/%i
+ExecStart=3D/usr/bin/ceph-mds -f --cluster ${CLUSTER} --id %i --setuse=
r
ceph --setgroup ceph -m ${BIND_IPV4}:${BIND_PORT}
 ExecReload=3D/bin/kill -HUP $MAINPID
 PrivateDevices=3Dyes
 ProtectHome=3Dtrue

=46irst you should note the extra EnvironmentFile line:

EnvironmentFile=3D-/var/lib/ceph/mds/systemd/%i

This means that if the mds service is started with parameter "param_one=
"
then the environment will be set with the content of

    /var/lib/ceph/env/mds/param_one

The "-" means don=E2=80=99t error if the above file does not exist.

Hence we could add service instance variables such as ${BIND_IPV4} and
${BIND_PORT} as well as important values like ${CLUSTER} to values like
ceph.

Having played with systemd, it seems that environment variables are
updated by the last assignment in systemd just like shell.

I have *not* found a good way to put in conditionals in such systemd
"EnvironmentFile" content. Hence it would be impossible to nicely
default command line parameters without using dirty tricks. Specificall=
y
what we cant do in the systemd "EnvironmentFile" context:

	if [ X"${BIND_IPV4}${BIND_PORT}" !=3D X ] ; then
	EXTRA_ARGS=3D"-m ${BIND_IPV4}:${BIND_PORT}"
	fi

Hence I think we have to accept to integrate with systemd nicely we
should allow setting to be read from environment rather than only from
the command line.

What do people think?

Best wishes

Owen



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
