From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw subuser create and admin api
Date: Thu, 17 Dec 2015 11:36:53 -0800
Message-ID: <CADRKj5Rs4DeVGuZ-9hhFLNW2bMHQ44jsKjUtHw66yHApGVzD2g@mail.gmail.com>
References: <5672EB1F.9070209@umiacs.umd.edu>
	<CADRKj5Ru=HhbhYGXq829oKPiB6Wr+9b8qgxjtmCn207xfCdc0Q@mail.gmail.com>
	<56730775.3070906@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33022 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbbLQTgy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 14:36:54 -0500
Received: by mail-ob0-f180.google.com with SMTP id sd4so65359342obb.0
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 11:36:54 -0800 (PST)
In-Reply-To: <56730775.3070906@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Derek Yarnell <derek@umiacs.umd.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 17, 2015 at 11:05 AM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
> On 12/17/15 1:09 PM, Yehuda Sadeh-Weinraub wrote:
>>> Bug? Design?
>>
>> Somewhat a bug. The whole subusers that use s3 was unintentional, so
>> when creating the subuser api, we didn't think of needing the access
>> key. For some reason we do get the key type. Can you open a ceph
>> tracker issue for that?
>>
>> You can try using the metadata api to modify the user once it has been
>> created (need to get the user info, add the s3 key to the structure,
>> put the user info).
>>
>
> This will actually create a subuser and the S3 keys correctly (but not
> let you specify the access_key and secret_key).
>
> DEBUG:requests.packages.urllib3.connectionpool:"PUT
> /admin/user?subuser&format=json&uid=-staff&subuser=test3&key-type=s3&access=read&generate-secret=True
> HTTP/1.1" 200 87
>
> I know about a 'GET /admin/metadata/user?format=json' to get the list of
> users from the adminops.  I see I can do things like 'radosgw-admin
> metadata get user:cephtest' but I can't seem to get something like this
> to work.
>
> DEBUG:requests.packages.urllib3.connectionpool:"GET
> /admin/metadata/get?format=json&key=user%3Acephtest HTTP/1.1" 404 20
> ERROR:rgwadmin.rgw:{u'Code': u'NoSuchKey'}
>

Try 'section=user&key=cephtests'

>
> --
> Derek T. Yarnell
> University of Maryland
> Institute for Advanced Computer Studies
