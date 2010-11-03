From: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>
Subject: continuous writing of same file
Date: Wed, 3 Nov 2010 23:10:52 +0530
Message-ID: <AANLkTin9ZnME53-wE_ZLNn5TAm+3ibmBZXfBF0G55Oc-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49857 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0KCRkx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Nov 2010 13:40:53 -0400
Received: by wyf28 with SMTP id 28so839533wyf.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Nov 2010 10:40:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I am using kernel client based Ceph version 0.21.1 on linux kernel
2.6.35. I am using a six node cluster with 3 machines and 3 virtual
machines.
=A0I wrote a simple program to continuously write to a file. After a fe=
w
iterations, the test gets stuck. Sometimes i am unable to unmount the
ceph mountpt subsequently.
I am using the following code
--
int main()
{

=A0=A0=A0 FILE *fp;
=A0=A0=A0 int i;
=A0=A0=A0 int written_before_stat;
=A0=A0=A0 int ret_value;


=A0=A0=A0 /* some junk buffer*/
=A0=A0=A0 char buffer[1024* SIZEOF_ONE_NODE];

=A0=A0=A0 char tbuffer[30];
=A0=A0=A0 struct timeval tv;

=A0=A0=A0 time_t curtime;

=A0=A0=A0 gettimeofday(&tv, NULL);
=A0=A0=A0 curtime=3Dtv.tv_sec;

=A0=A0=A0 strftime(tbuffer,30,"%m-%d-%Y=A0 %T.",localtime(&curtime));
=A0=A0=A0 printf("%s%ld\t|",tbuffer,tv.tv_usec);


=A0=A0=A0 printf("starting....\n");
=A0=A0=A0 printf("infinite loop. Ctrl+C when you wish !!\n");

=A0=A0=A0 /* keep writing to the ceph file*/
=A0=A0=A0 /* infinite loop. Ctrl+C when you wish*/
=A0=A0=A0 while(1)
=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0 /* the frenetic writing phase */

=A0=A0=A0 =A0=A0=A0 fp =3D fopen("/ceph/test_file1","w");
=A0=A0=A0 =A0=A0=A0 if(fp =3D=3D NULL)
=A0=A0=A0 =A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 printf("ceph dir write file open err\n");

=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 exit(-1);
=A0=A0=A0 =A0=A0=A0 }
=A0=A0=A0 =A0=A0=A0 for(i =3D 0; i < 1024 ;i++)
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 fwrite(buffer, sizeof(buffer[0]),
sizeof(buffer)/sizeof(buffer[0]), fp);

=A0=A0=A0 =A0=A0=A0 fclose(fp);
=A0=A0=A0 =A0=A0=A0 gettimeofday(&tv, NULL);
=A0=A0=A0 =A0=A0=A0 curtime=3Dtv.tv_sec;

=A0=A0=A0 =A0=A0=A0 strftime(tbuffer,30,"%m-%d-%Y=A0 %T.",localtime(&cu=
rtime));
=A0=A0=A0 =A0=A0=A0 printf("%s%ld\t|",tbuffer,tv.tv_usec);

=A0=A0=A0 =A0=A0=A0 printf("120MB written..\n");
=A0=A0=A0 =A0=A0=A0 fflush(stdout);
=A0=A0=A0 =A0=A0=A0 usleep(1000);

=A0=A0=A0 }


}
--------
Am i missing something?. Thanks for any help.

Thanks,
Mugunthan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
