From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: Efficiently scan all objects in a rados pool/namespace
Date: Wed, 16 Oct 2013 14:55:18 +0800
Message-ID: <CAMm-wc+RTAO+C4CE_4JP2-EiX3B3LHbEO5Mn1xR0U8BxPuA9VQ@mail.gmail.com>
References: <loom.20131016T060803-617@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63440 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab3JPGzU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Oct 2013 02:55:20 -0400
Received: by mail-wi0-f174.google.com with SMTP id cb5so6177141wib.13
        for <ceph-devel@vger.kernel.org>; Tue, 15 Oct 2013 23:55:19 -0700 (PDT)
In-Reply-To: <loom.20131016T060803-617@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amit Tiwary <tiwaryamt@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The object is ordered by their hash code (from Object Name).

By default, the HashIndex is used to define the relation between
Object Name and Local File Path, so you can find the details from
HashIndex.cc::list_by_hash

Listing object means to scan the disk by current implementation, so
maybe you should store the object list in other formats, they may be a
certain object or centain objects which contain the object list or
even another database(MySql).

Hope it is helpful.

On 16 October 2013 12:48, Amit Tiwary <tiwaryamt@gmail.com> wrote:
> We are using ceph version 0.56.6, librados C++ APIs and have more than 750
> million objects in a single pool. Objects are named as "domain-name_file-
> name".
>
> We are unable to ascertain in what order objects are listed with the command
> "rados -p poolname ls". They are neither ordered on objectname, nor size or
> mtime.
>
> Q1) Is there any way we can control the way objects are scanned/listed in a
> pool with the below librados c++ code? We are interested in getting list of
> objects sorted or grouped by object name
>     librados::ObjectIterator it = ioctx.objects_begin();
>     for (; it != ioctx.objects_end(); ++it)
>         ...
>
> Q2) In near future, if we upgrade and make use of namespaces (i.e make
> domain-name as namespace and store all objects of a particular domain in that
> namespace); would scanning of objects in a namespace be efficient than
> current scenario where we have to scan the entire pool to fetch all objects?
>
> Q3) Do you any other recommendations on top of your mind that can improve
> time required to scan all objects of pool/namespace?
>
> Thanks,
> Amit Tiwary
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
