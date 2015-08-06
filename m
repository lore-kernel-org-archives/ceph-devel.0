From: =?UTF-8?B?xYF1a2Fzeg==?= Szymczyk <lukasz.szymczyk@corp.ovh.com>
Subject: Newbie question about metadata_list.
Date: Thu, 6 Aug 2015 11:26:30 +0200
Message-ID: <20150806112630.d3c4ed783a07dfefb0d6dbc6@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mo69.mail-out.ovh.net ([178.32.228.69]:49034 "EHLO
	mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbbHFKqD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 06:46:03 -0400
Received: from mail611.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with SMTP id 3764EFFB06B
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2015 11:27:22 +0200 (CEST)
Received: from localhost (lszymczy.local.lp [10.40.0.52])
	by proxy.pl.ovh.net (Postfix) with ESMTP id C4728100B86
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2015 11:25:26 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm writing some program to replace image in cluster with it's copy.
But I have problem with metadata_list.
I created pool:
#rados mkpool dupa
then I created image:
#rbd create --size 1000 -p mypool image --image-format 2

Below is code which tries to get metadata, but it fails with -EOPNOTSUP=
P.
I compile it with command like this:
g++ file.cpp -lrbd -lrados -I/ceph/source/directory/src

#include <stdio.h>
#include <stdlib.h>
#include "include/rbd/librbd.h"
#include "include/rbd/librbd.hpp"
using namespace ceph;
#include "librbd/ImageCtx.h"

int main() {
	rados_t clu;
	int ret =3D rados_create(&clu, NULL);
	if (ret) return -1;

	ret =3D rados_conf_read_file(clu, NULL);
	if (ret) return -1;

	rados_conf_parse_env(clu, NULL);
	ret =3D rados_connect(clu);
	if (ret) return -1;

	rados_ioctx_t io;
	ret =3D rados_ioctx_create(clu, "mypool", &io);
	if (ret) return -1;

	rbd_image_t im;
	ret =3D rbd_open(io, "image", &im, NULL);
	if (ret) return -1;

	librbd::ImageCtx *ic =3D (librbd::ImageCtx*)im;
	std::string start;
	int max =3D 1000;
	bufferlist in, out;
	::encode(start, in);
	::encode(max, in);
	ret =3D ((librados::IoCtx*)&io)->exec(ic->header_oid, "rbd", "metadata=
_list", in, out);
	if (ret < 0) printf("fail\n");

	return 0;

}

So, my question is: what should be set/enabled to get those metadata?
Or maybe what I'm doing wrong here.
Thanks for your help.

Best regards,
=C5=81ukasz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
