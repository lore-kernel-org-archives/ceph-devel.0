From: David Zafman <david.zafman@inktank.com>
Subject: Re: xattr limits
Date: Thu, 3 Oct 2013 23:54:29 -0700
Message-ID: <31BF914D-D406-428E-8671-0005901E10E6@inktank.com>
References: <C1F9D079-3D19-4A39-872A-0CAF8EA3866F@gmail.com> <524E59FC.9030903@dachary.org>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/mixed; boundary="Apple-Mail=_6411C04D-6730-4563-B855-7159416D3E34"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:42738 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab3JDGyd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Oct 2013 02:54:33 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so3452167oag.6
        for <ceph-devel@vger.kernel.org>; Thu, 03 Oct 2013 23:54:32 -0700 (PDT)
In-Reply-To: <524E59FC.9030903@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Loic Dachary <loic@dachary.org>


--Apple-Mail=_6411C04D-6730-4563-B855-7159416D3E34
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=windows-1252


Here is the test script:


--Apple-Mail=_6411C04D-6730-4563-B855-7159416D3E34
Content-Disposition: attachment;
	filename=xattr-test.sh
Content-Type: application/octet-stream;
	name="xattr-test.sh"
Content-Transfer-Encoding: 7bit

#! /bin/sh

#getfattr format
#
# # file: foo
# user.test="test"

if [ $# != "2" ];
then
  echo usage: $0 path count
  exit 1
fi

FILENAME=$1
COUNT=$2

rmdir $FILENAME > /dev/null 2>&1

datalen=65536
echo "datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata" > tmp.$$
while test $datalen != 0
do
  dd if=tmp.$$ of=src.$$ bs=512 count=1 conv=notrunc oflag=append 2> /dev/null
  datalen=`expr $datalen - 512`
done
rm tmp.$$

for len in 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536
do
  mkdir $FILENAME

  echo $len

  count=0
  while test $count != $COUNT
  do
    entry=user.test`expr $count + 1`
    echo "# file: $FILENAME" > data.$$
    echo -n "$entry" >> data.$$
    echo -n '="' >> data.$$
    dd if=src.$$ of=data.$$ bs=$len count=1 conv=notrunc oflag=append 2> /dev/null
    echo '"' >> data.$$
    #cat data.$$
    #read a
    setfattr --restore=data.$$
    if [ $? != "0" ];
    then
        echo failure to set $entry
        break
    fi
    count=`expr $count + 1`
    #getfattr --dump $FILENAME
  done
  rm data.$$
  rmcount=0
  while test $rmcount != $count
  do
    entry=user.test`expr $rmcount + 1`
    setfattr --remove=$entry $FILENAME
    if [ $? != "0" ];
    then
      echo failure to remove $entry
      break
    fi
    rmcount=`expr $rmcount + 1`
  done
  getfattr --dump $FILENAME
  rmdir $FILENAME
done
rm src.$$

exit 0

--Apple-Mail=_6411C04D-6730-4563-B855-7159416D3E34
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


David Zafman
Senior Developer
http://www.inktank.com




On Oct 3, 2013, at 11:02 PM, Loic Dachary <loic@dachary.org> wrote:

> Hi David,
>=20
> Would you mind attaching the script to the mail for completness ? It's =
a useful thing to have :-)
>=20
> Cheers
>=20
> On 04/10/2013 01:21, David Zafman wrote:
>>=20
>> I want to record with the ceph-devel archive results from testing =
limits of xattrs for Linux filesystems used with Ceph.
>>=20
>> Script that creates xattrs with name user.test1, user.test2, =85. on =
a single file
>> 3.10 linux kernel
>>=20
>> ext4 =20
>> value bytes       number of entries
>>    1               148
>>   16             103
>>  256          14
>>  512            7
>>  1024         3
>> 4036          1=20
>> Beyond this immediately get ENOSPC
>>=20
>> btrfs   =20
>> value bytes       number of entries
>> 8       		 10k
>> 16       		10k
>> 32        		 10k
>> 64        		 10k
>> 128     		 10k
>> 256       		 10k
>> 512        		10k  slow but worked 1,000,000 got completely =
hung for minutes at a time during removal strace showed no forward =
progress
>> 1024        	 10k
>> 2048        	 10k
>> 3096          	 10k
>> Beyond this you start getting ENOSPC after fewer entries
>>=20
>> xfs (limit entries due to xfs crash with 10k entries)
>> value bytes       number of entries
>> 1   			1k
>> 8   			 1k
>> 16   			 1k
>> 32  			 1k
>> 64   		        1k
>> 128   		 1k
>> 256 			1k
>> 512  		 1k
>> 1024 		1k
>> 2048  		 1k
>> 4096   		 1k
>> 8192   		 1k
>> 16384   		 1k
>> 32768   		 1k
>> 65536   		 1k
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>=20


--Apple-Mail=_6411C04D-6730-4563-B855-7159416D3E34--
