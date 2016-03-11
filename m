From: John Hunter <zhjwpku@gmail.com>
Subject: [GSoC 2016] ON-THE-WIRE ENCRYPTION SUPPORT
Date: Fri, 11 Mar 2016 13:38:51 +0800
Message-ID: <CAEG8a3KgxDHU03JDccrU_h7S8GksO8hfM2tcxLak=R1tKBXfMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34589 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbcCKFiw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2016 00:38:52 -0500
Received: by mail-vk0-f47.google.com with SMTP id e185so122519877vkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2016 21:38:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage A. Weil" <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi sage,

At a quick look at the ceph codebase, the cryptographic handshake is handled
by the Pipe class(I might be wrong), it not using the openssl handshake and not
using the openssl crypto library. I am wondering when we encrypt the actual
data, are we going to implement our own encrypt functions?

I am familar with Openssl, I am still a little confused about the project(mostly
if I can use openssl to encrypt the on wire data). It would nice if
you could explain
it a little more.

PS: my previous work can be found here[1]
[1] https://github.com/zhjwpku

Best Regards,
Zhao
