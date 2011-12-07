From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Client stuck 'waiting on max_size'
Date: Tue, 6 Dec 2011 20:02:23 -0800 (PST)
Message-ID: <1340951383.133589.1323230543007.JavaMail.root@mail-01.cse.ucsc.edu>
References: <726402583.133585.1323230432339.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:46220 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab1LGECX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 23:02:23 -0500
Received: from mail-01.cse.ucsc.edu (mail-01.cse.ucsc.edu [128.114.48.32])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTP id 1A6B31009C19
	for <ceph-devel@vger.kernel.org>; Tue,  6 Dec 2011 20:02:23 -0800 (PST)
In-Reply-To: <726402583.133585.1323230432339.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have a simple libcephfs client (code attached) that:

1) mounts ceph
2) opens/create a file
3) writes 1K

But gets stuck on the write. The client log repeats the following over and over. (c code for test appended).

Thanks,
Noah


2011-12-06 19:50:23.329501 7ff3a7023700 client.6154  cap mds.0 issued pAsLsXsFscr implemented pAsLsXsFscr revoking -
2011-12-06 19:50:37.330474 7ff3a7023700 client.6154 renew_caps()
2011-12-06 19:50:37.330536 7ff3a7023700 client.6154 renew_caps requesting from mds.0
2011-12-06 19:50:37.330549 7ff3a7023700 client.6154 renew_caps mds.0
2011-12-06 19:50:37.331304 7ff3a6021700 client.6154 handle_client_session client_session(renewcaps seq 4) v1
2011-12-06 19:50:37.331357 7ff3a9eb7760 client.6154 waiting on max_size, endoff 1024 max_size 0
2011-12-06 19:50:57.331975 7ff3a7023700 client.6154 renew_caps()
2011-12-06 19:50:57.332021 7ff3a7023700 client.6154 renew_caps requesting from mds.0
2011-12-06 19:50:57.332036 7ff3a7023700 client.6154 renew_caps mds.0
2011-12-06 19:50:57.332757 7ff3a6021700 client.6154 handle_client_session client_session(renewcaps seq 5) v1
2011-12-06 19:50:57.332809 7ff3a9eb7760 client.6154 waiting on max_size, endoff 1024 max_size 0
2011-12-06 19:51:17.333445 7ff3a7023700 client.6154 renew_caps()
2011-12-06 19:51:17.333492 7ff3a7023700 client.6154 renew_caps requesting from mds.0
2011-12-06 19:51:17.333507 7ff3a7023700 client.6154 renew_caps mds.0
2011-12-06 19:51:17.334220 7ff3a6021700 client.6154 handle_client_session client_session(renewcaps seq 6) v1
2011-12-06 19:51:17.334274 7ff3a9eb7760 client.6154 waiting on max_size, endoff 1024 max_size 0
2011-12-06 19:51:37.334880 7ff3a7023700 client.6154 renew_caps()
2011-12-06 19:51:37.334927 7ff3a7023700 client.6154 renew_caps requesting from mds.0
2011-12-06 19:51:37.334941 7ff3a7023700 client.6154 renew_caps mds.0
2011-12-06 19:51:37.335657 7ff3a6021700 client.6154 handle_client_session client_session(renewcaps seq 7) v1
2011-12-06 19:51:37.335707 7ff3a9eb7760 client.6154 waiting on max_size, endoff 1024 max_size 0
2011-12-06 19:51:57.336312 7ff3a7023700 client.6154 renew_caps()
2011-12-06 19:51:57.336356 7ff3a7023700 client.6154 renew_caps requesting from mds.0
2011-12-06 19:51:57.336370 7ff3a7023700 client.6154 renew_caps mds.0
2011-12-06 19:51:57.337057 7ff3a6021700 client.6154 handle_client_session client_session(renewcaps seq 8) v1
2011-12-06 19:51:57.337109 7ff3a9eb7760 client.6154 waiting on max_size, endoff 1024 max_size 0
2011-12-06 19:52:17.337745 7ff3a7023700 client.6154 renew_caps()
2011-12-06 19:52:17.337791 7ff3a7023700 client.6154 renew_caps requesting from mds.0
2011-12-06 19:52:17.337805 7ff3a7023700 client.6154 renew_caps mds.0
2011-12-06 19:52:17.338499 7ff3a6021700 client.6154 handle_client_session client_session(renewcaps seq 9) v1
2011-12-06 19:52:17.338550 7ff3a9eb7760 client.6154 waiting on max_size, endoff 1024 max_size 0
2011-12-06 19:52:37.339187 7ff3a7023700 client.6154 renew_caps()
2011-12-06 19:52:37.339236 7ff3a7023700 client.6154 renew_caps requesting from mds.0
2011-12-06 19:52:37.339250 7ff3a7023700 client.6154 renew_caps mds.0
2011-12-06 19:52:37.339968 7ff3a6021700 client.6154 handle_client_session client_session(renewcaps seq 10) v1
2011-12-06 19:52:37.340015 7ff3a9eb7760 client.6154 waiting on max_size, endoff 1024 max_size 0


=============

#define _FILE_OFFSET_BITS 64
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cephfs/libcephfs.h>

#define MB64 (1<<26)

int main(int argc, const char **argv)
{
	struct ceph_mount_info *cmount;
	int ret, fd, len;
	char buf[1024];

	if (argc < 3) {
		fprintf(stderr, "usage: ./%s <conf> <file>\n", argv[0]);
		exit(1);
	}

	ret = ceph_create(&cmount, NULL);
	if (ret) {
		fprintf(stderr, "ceph_create=%d\n", ret);
		exit(1);
	}

	ret = ceph_conf_read_file(cmount, argv[1]);
	if (ret) {
		fprintf(stderr, "ceph_conf_read_file=%d\n", ret);
		exit(1);
	}

	ret = ceph_conf_parse_argv(cmount, argc, argv);
	if (ret) {
		fprintf(stderr, "ceph_conf_parse_argv=%d\n", ret);
		exit(1);
	}

	ret = ceph_mount(cmount, NULL);
	if (ret) {
		fprintf(stderr, "ceph_mount=%d\n", ret);
		exit(1);
	}

	ret = ceph_chdir(cmount, "/");
	if (ret) {
		fprintf(stderr, "ceph_chdir=%d\n", ret);
		exit(1);
	}

	fd = ceph_open(cmount, argv[2], O_CREAT|O_TRUNC, 0777);	
	if (fd < 0) {
		fprintf(stderr, "ceph_open=%d\n", fd);
		exit(1);
	}

	memset(buf, 'a', sizeof(buf));

	len = ceph_write(cmount, fd, buf, sizeof(buf), 0);

	fprintf(stdout, "wrote %d bytes\n", len);

	ceph_shutdown(cmount);

	return 0;
}
