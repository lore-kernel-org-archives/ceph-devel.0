From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Client stuck 'waiting on max_size'
Date: Tue, 6 Dec 2011 20:49:22 -0800
Message-ID: <CAF3hT9DHJ6gRxU_d3niH_LrgL=zHcEgaYSXgH+DTq+1ZEOU9+w@mail.gmail.com>
References: <726402583.133585.1323230432339.JavaMail.root@mail-01.cse.ucsc.edu>
	<1340951383.133589.1323230543007.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65203 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab1LGEtX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 23:49:23 -0500
Received: by iakc1 with SMTP id c1so302198iak.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2011 20:49:22 -0800 (PST)
In-Reply-To: <1340951383.133589.1323230543007.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The client is waiting for the MDS to give it permission to make the
file larger. I think this data comes back in a caps message, but it
probably got stuck on the MDS for some reason. Try grepping through
the MDS and client logs for max_size and see if there's something
obvious (or send it our way).

On Tue, Dec 6, 2011 at 8:02 PM, Noah Watkins <jayhawk@soe.ucsc.edu> wro=
te:
> I have a simple libcephfs client (code attached) that:
>
> 1) mounts ceph
> 2) opens/create a file
> 3) writes 1K
>
> But gets stuck on the write. The client log repeats the following ove=
r and over. (c code for test appended).
>
> Thanks,
> Noah
>
>
> 2011-12-06 19:50:23.329501 7ff3a7023700 client.6154 =A0cap mds.0 issu=
ed pAsLsXsFscr implemented pAsLsXsFscr revoking -
> 2011-12-06 19:50:37.330474 7ff3a7023700 client.6154 renew_caps()
> 2011-12-06 19:50:37.330536 7ff3a7023700 client.6154 renew_caps reques=
ting from mds.0
> 2011-12-06 19:50:37.330549 7ff3a7023700 client.6154 renew_caps mds.0
> 2011-12-06 19:50:37.331304 7ff3a6021700 client.6154 handle_client_ses=
sion client_session(renewcaps seq 4) v1
> 2011-12-06 19:50:37.331357 7ff3a9eb7760 client.6154 waiting on max_si=
ze, endoff 1024 max_size 0
> 2011-12-06 19:50:57.331975 7ff3a7023700 client.6154 renew_caps()
> 2011-12-06 19:50:57.332021 7ff3a7023700 client.6154 renew_caps reques=
ting from mds.0
> 2011-12-06 19:50:57.332036 7ff3a7023700 client.6154 renew_caps mds.0
> 2011-12-06 19:50:57.332757 7ff3a6021700 client.6154 handle_client_ses=
sion client_session(renewcaps seq 5) v1
> 2011-12-06 19:50:57.332809 7ff3a9eb7760 client.6154 waiting on max_si=
ze, endoff 1024 max_size 0
> 2011-12-06 19:51:17.333445 7ff3a7023700 client.6154 renew_caps()
> 2011-12-06 19:51:17.333492 7ff3a7023700 client.6154 renew_caps reques=
ting from mds.0
> 2011-12-06 19:51:17.333507 7ff3a7023700 client.6154 renew_caps mds.0
> 2011-12-06 19:51:17.334220 7ff3a6021700 client.6154 handle_client_ses=
sion client_session(renewcaps seq 6) v1
> 2011-12-06 19:51:17.334274 7ff3a9eb7760 client.6154 waiting on max_si=
ze, endoff 1024 max_size 0
> 2011-12-06 19:51:37.334880 7ff3a7023700 client.6154 renew_caps()
> 2011-12-06 19:51:37.334927 7ff3a7023700 client.6154 renew_caps reques=
ting from mds.0
> 2011-12-06 19:51:37.334941 7ff3a7023700 client.6154 renew_caps mds.0
> 2011-12-06 19:51:37.335657 7ff3a6021700 client.6154 handle_client_ses=
sion client_session(renewcaps seq 7) v1
> 2011-12-06 19:51:37.335707 7ff3a9eb7760 client.6154 waiting on max_si=
ze, endoff 1024 max_size 0
> 2011-12-06 19:51:57.336312 7ff3a7023700 client.6154 renew_caps()
> 2011-12-06 19:51:57.336356 7ff3a7023700 client.6154 renew_caps reques=
ting from mds.0
> 2011-12-06 19:51:57.336370 7ff3a7023700 client.6154 renew_caps mds.0
> 2011-12-06 19:51:57.337057 7ff3a6021700 client.6154 handle_client_ses=
sion client_session(renewcaps seq 8) v1
> 2011-12-06 19:51:57.337109 7ff3a9eb7760 client.6154 waiting on max_si=
ze, endoff 1024 max_size 0
> 2011-12-06 19:52:17.337745 7ff3a7023700 client.6154 renew_caps()
> 2011-12-06 19:52:17.337791 7ff3a7023700 client.6154 renew_caps reques=
ting from mds.0
> 2011-12-06 19:52:17.337805 7ff3a7023700 client.6154 renew_caps mds.0
> 2011-12-06 19:52:17.338499 7ff3a6021700 client.6154 handle_client_ses=
sion client_session(renewcaps seq 9) v1
> 2011-12-06 19:52:17.338550 7ff3a9eb7760 client.6154 waiting on max_si=
ze, endoff 1024 max_size 0
> 2011-12-06 19:52:37.339187 7ff3a7023700 client.6154 renew_caps()
> 2011-12-06 19:52:37.339236 7ff3a7023700 client.6154 renew_caps reques=
ting from mds.0
> 2011-12-06 19:52:37.339250 7ff3a7023700 client.6154 renew_caps mds.0
> 2011-12-06 19:52:37.339968 7ff3a6021700 client.6154 handle_client_ses=
sion client_session(renewcaps seq 10) v1
> 2011-12-06 19:52:37.340015 7ff3a9eb7760 client.6154 waiting on max_si=
ze, endoff 1024 max_size 0
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> #define _FILE_OFFSET_BITS 64
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <cephfs/libcephfs.h>
>
> #define MB64 (1<<26)
>
> int main(int argc, const char **argv)
> {
> =A0 =A0 =A0 =A0struct ceph_mount_info *cmount;
> =A0 =A0 =A0 =A0int ret, fd, len;
> =A0 =A0 =A0 =A0char buf[1024];
>
> =A0 =A0 =A0 =A0if (argc < 3) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "usage: ./%s <conf> <f=
ile>\n", argv[0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0ret =3D ceph_create(&cmount, NULL);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "ceph_create=3D%d\n", =
ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0ret =3D ceph_conf_read_file(cmount, argv[1]);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "ceph_conf_read_file=3D=
%d\n", ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0ret =3D ceph_conf_parse_argv(cmount, argc, argv);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "ceph_conf_parse_argv=3D=
%d\n", ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0ret =3D ceph_mount(cmount, NULL);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "ceph_mount=3D%d\n", r=
et);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0ret =3D ceph_chdir(cmount, "/");
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "ceph_chdir=3D%d\n", r=
et);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0fd =3D ceph_open(cmount, argv[2], O_CREAT|O_TRUNC, 077=
7);
> =A0 =A0 =A0 =A0if (fd < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "ceph_open=3D%d\n", fd=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0memset(buf, 'a', sizeof(buf));
>
> =A0 =A0 =A0 =A0len =3D ceph_write(cmount, fd, buf, sizeof(buf), 0);
>
> =A0 =A0 =A0 =A0fprintf(stdout, "wrote %d bytes\n", len);
>
> =A0 =A0 =A0 =A0ceph_shutdown(cmount);
>
> =A0 =A0 =A0 =A0return 0;
> }
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
