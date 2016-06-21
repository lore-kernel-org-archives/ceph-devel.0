From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: [rgw] hammer bucket object versions
Date: Tue, 21 Jun 2016 11:56:32 +0200
Message-ID: <CABo9giR=bumDM6sC3W6Re1gNAfgxOnN+ys6eLYBhPXzZKtTeaw@mail.gmail.com>
References: <dbde742b69564ec797c8d52355759901@MBX1.croc.ru>
	<1466441877817.58217@croc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33404 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbcFUKCK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 06:02:10 -0400
Received: by mail-lb0-f170.google.com with SMTP id xp5so7364142lbb.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2016 03:01:52 -0700 (PDT)
In-Reply-To: <1466441877817.58217@croc.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Odintsov Vladislav <VlOdintsov@croc.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This looks like a documentation error

Orit

On Mon, Jun 20, 2016 at 6:58 PM, Odintsov Vladislav <VlOdintsov@croc.ru> wrote:
> Hi all,
>
> I see in the documentation, that in hammer bucket object versioning is unsupported.
> http://docs.ceph.com/docs/hammer/radosgw/s3/#features-support
>
> But, if I use boto with hammer-based ceph s3 cluster, it seems, that it works:
>>>> import boto.s3.connection
>>>> conn = boto.s3.connection.S3Connection(aws_access_key_id=access_key,
> ...             aws_secret_access_key=secret_key,
> ...             host=host, port=port,
> ...             validate_certs=validate_certs,
> ...             is_secure=is_secure, debug=debug,
> ...             suppress_consec_slashes=suppress_consec_slashes,
> ...             calling_format=boto.s3.connection.OrdinaryCallingFormat()
> ...         )
>>>> bucket = conn.create_bucket("test_bucket2")
>>>> bucket.configure_versioning(True)
>>>> key = bucket.new_key("versioned_object")
>>>> key.set_contents_from_string("Version 1")
> 9
>>>> key.set_contents_from_string("Version 2")
> 9
>>>> for k in bucket.list_versions('versioned_object'):
> ...     k.version_id
> ...
> u'2cCJJQBE7XHz7OSxk3ZvH6DNh5Q6vOi'
> u'I51r-J5NpQ44TZI.iRwyukBZ5NOyriO'
>>>> for k in bucket.list_versions('versioned_object'):
> ...     k.get_contents_as_string()
> ...
> 'Version 2'
> 'Version 1'
>>>> bucket.get_key('versioned_object').get_contents_as_string()
> 'Version 2'
>>>> bucket.copy_key(new_key_name='versioned_object', src_bucket_name='test_bucket2', src_key_name='versioned_object', src_version_id='I51r-J5NpQ44TZI.iRwyukBZ5NOyriO')
> <Key: test_bucket2,versioned_object>
>>>> bucket.get_key('versioned_object').get_contents_as_string()
> 'Version 1'
>>>> list(bucket.list_versions('versioned_object'))
> [<Key: test_bucket2,versioned_object>, <Key: test_bucket2,versioned_object>, <Key: test_bucket2,versioned_object>]
>
>
> I'd like to clarify, is it non-production ready in hammer, or it's a documentation error?
>
>
> Regards,
>
> Vladislav Odintsov
