From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Rados faster than KVM block device?
Date: Thu, 28 Jun 2012 09:39:34 -0700
Message-ID: <CADvuQRFjVX1pXR7+Duv8PkH+jCo11pdxnOD7Psho-YHSn=rkUQ@mail.gmail.com>
References: <4FEC57BE.9060703@profihost.ag> <4FEC8252.90208@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54999 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab2F1Qjy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 12:39:54 -0400
Received: by dady13 with SMTP id y13so3104554dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 09:39:54 -0700 (PDT)
In-Reply-To: <4FEC8252.90208@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 28, 2012 at 9:12 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> Keep in mind it's running on a filesystem, so requests go through the
> guest fs and block layer before getting into librbd. These two layers

Quick side note: an easy way to get around the filesystem is to use
rbd as the *second* hard drive for a vm, and not even mkfs it. Run
tests on the raw block device.
