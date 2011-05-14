From: Simon Tian <aixt2006@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Sat, 14 May 2011 11:26:17 +0800
Message-ID: <BANLkTim9vg_TkakNnnTHDgHL8xAMbvqGng@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
	<BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
	<BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
	<BANLkTinO=rYk8wOvO50EKyzbHTjrjk_dvQ@mail.gmail.com>
	<BANLkTikRzuukqpwkEceMB9ZiRY-SUPFxuA@mail.gmail.com>
	<BANLkTikPk32SMy0-bNrto8+6tSajciZ4pw@mail.gmail.com>
	<Pine.LNX.4.64.1105130854110.12286@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37615 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759617Ab1END0T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 23:26:19 -0400
Received: by wya21 with SMTP id 21so2316055wya.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 May 2011 20:26:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105130854110.12286@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

>> BTW, I have 2 question:
>> 1. =C2=A0 In these scenario, after I execute "cclass -a" and "ceph c=
lass
>> activate rbd 1.3", =C2=A0I need to wait for several second before cr=
eate
>> rbd, otherwise, "librbd: failed to assign a block name for image" wi=
ll
>> come out. Is this all right?
>
> For 0.27 and previous, yes. =C2=A0The class distribution has removed =
in v0.28
> and it is now the administrator's (make install's, dpkg's, rpm's)
> responsibility to put the .so in the right directory. =C2=A0This is m=
uch
> simpler all around and easier to debug. =C2=A0If you are still having=
 any class
> loading problems you should try the 'next' branch which will soon bec=
ome
> v0.28.

OK,  I'll try v0.28.
How to enable the debug of the libs (librbd, librados....)? I debug
testlibrbd in gdb to see the backtrace, but can't got the context in
the libs.


>> 2. =C2=A0 I run some test with a modified testlibrbd.c, code add lik=
e:
>>
>> gettimeofday(&tv1, NULL);
>> =C2=A0 for (i =3D 0; i < num_test; i++)
>> =C2=A0 =C2=A0 write_test_data(image, test_data, TEST_IO_SIZE * i, TE=
ST_IO_SIZE);
>> gettimeofday(&tv2, NULL);
>> t1 =3D tv2.tv_sec-tv1.tv_sec;
>> temp =3D (float)t1 + (tv2.tv_usec-tv1.tv_usec)/1000000.0;
>> speed =3D 1.0*TEST_IO_SIZE*num_test/temp/1024/1024;
>> printf("time used: temp=3D%.3f\n", temp);
>> printf("write speed: %.2f MB/s\n", speed);
>>
>> The result I got is so slowly:
>> time used: temp=3D46.611
>> write speed: 0.21 MB/s
>> time used: temp=3D14.706
>> read speed: 0.68 MB/s
>> time used: temp=3D45.453
>> aio write speed: 0.22 MB/s
>> time used: temp=3D14.759
>> aio read speed: 0.68 MB/s
>>
>> But while the test, some cosd process is running with high CPU usage=
=2E
>
> What is the IO size? =C2=A0Is write_test_data synchronous?
>
> For simple write benchmarking you can also use
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rados mkpool foo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rados -p foo bench <seconds> write -b <blo=
cksize> -t <threads>
>
> and you'll see latency and throughput. =C2=A0Blocksize defaults to 4M=
 and
> "threads" (parallel IOs) default to 16, IIRC.

The IO size is TEST_IO_SIZE=3D512,  write_test_data is just synchronous=
,
it call the rbd_write( ) function.
aio write speed is 0.22 MB/s which called rbd_aio_write() function.
aio read speed is 0.68 MB/s which called  rbd_aio_read() function.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
