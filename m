From: KIMURA Osamu <kimura.osamu@jp.fujitsu.com>
Subject: Re: rgw: object listing hangs on versioned bucket
Date: Wed, 15 Jun 2016 14:26:02 +0900
Message-ID: <82fecbf6-ddac-3c0f-148c-410ac1e81c01@jp.fujitsu.com>
References: <574FFA9E.7060100@xtaotech.com>
 <ff7d8bc1-993c-04cb-be63-d782d09f6ecd@jp.fujitsu.com>
 <CABo9giRxyYpazw5qv=rb07z3br=X1SH4B946GAYGyXrOj22yyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:22900 "EHLO
	mgwym04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbcFOF0d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2016 01:26:33 -0400
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
	by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id BA271AC020A
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jun 2016 14:26:22 +0900 (JST)
In-Reply-To: <CABo9giRxyYpazw5qv=rb07z3br=X1SH4B946GAYGyXrOj22yyw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Orit Wasserman <owasserm@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

I opened a ticket with earlier log.
http://tracker.ceph.com/issues/16309

Thank you,
KIMURA

On 2016/06/14 19:21, Orit Wasserman wrote:
> It could be a different problem, can you open a new issue?
>
> Thanks,
> Orit
>
> On Tue, Jun 14, 2016 at 5:13 AM, KIMURA Osamu
> <kimura.osamu@jp.fujitsu.com> wrote:
>> Hello,
>>
>> An our customer got a problem on RADOSGW.
>> The customer tried to list objects on a versioned bucket with S3 API,
>> then they got 500 server error due to FastCGI timeout.
>> RGW's internal listing process continued over the night (approx 10hours)
>> until they restarted the RGW. Please see attached radosgw log.
>>
>> The behavior seems to be similar to bug#12913, but they are using
>> v0.94.6 of RGW. The bug should be resolved in the version.
>> http://tracker.ceph.com/issues/12913
>>
>> As we can find in the log, RGW repeatedly tried to get information
>> for a specific object (testfile1896.txt).
>>
>> The object has null version and another version as bellow.
>> Yes, versioning of the bucket was enabled after some objects had been
>> put in the bucket.
>>
>> Similar condition can be found in bug#15243, but the fix only affects
>> to deletion.
>> http://tracker.ceph.com/issues/15243
>>
>> Are there any problem remained in versioned object with null version?
>>
>>
>> Regards,
>> KIMURA
>>
>> ----------------------
>> <?xml version="1.0" encoding="UTF-8"?>
>> <ListVersionsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
>>  <Name>hojo-bucket-02</Name>
>>  <Prefix>testfile1896.txt</Prefix>
>>  <KeyMarker></KeyMarker>
>>  <MaxKeys>1000</MaxKeys>
>>  <IsTruncated>false</IsTruncated>
>>  <Version>
>>   <Key>testfile1896.txt</Key>
>>   <VersionId>2MSeTpZoDSqt2nTk1oYHZNmF1e84C.1</VersionId>
>>   <IsLatest>true</IsLatest>
>>   <LastModified>2016-05-30T08:39:52.000Z</LastModified>
>>   <ETag>&quot;1d24c7924b9798bb9064dcb043b3d989&quot;</ETag>
>>   <Size>3152</Size>
>>   <StorageClass>STANDARD</StorageClass>
>>   <Owner>
>>    <ID>XXXXXXXX</ID>
>>    <DisplayName>XXXXXXXX</DisplayName>
>>   </Owner>
>>  </Version>
>>  <Version>
>>   <Key>testfile1896.txt</Key>
>>   <VersionId>null</VersionId>
>>   <IsLatest>false</IsLatest>
>>   <LastModified>2016-05-30T02:43:22.000Z</LastModified>
>>   <ETag>&quot;20a4fc4c12598089a8937496a5eba67e&quot;</ETag>
>>   <Size>3052</Size>
>>   <StorageClass>STANDARD</StorageClass>
>>   <Owner>
>>    <ID>XXXXXXXX</ID>
>>    <DisplayName>XXXXXXXX</DisplayName>
>>   </Owner>
>>  </Version>
>> </ListVersionsResult>

-- 
KIMURA Osamu / 木村 修
Engineering Department, Storage Development Division,
Data Center Platform Business Unit, FUJITSU LIMITED
