/// <reference path="google.maps.d.ts"/>
module ew {
    export class MainController {
        map:google.maps.Map;
        circle:google.maps.Circle;
        model:MainModel;
        constructor() {
            this.model = new MainModel();

            window.addEventListener(DomEventKind.LOADED, ()=>{this.init();});
        }

        createLatLng(lat:number, lng:number):google.maps.LatLng {
            return new google.maps.LatLng(lat, lng);
        }

        createMaker(latLng:google.maps.LatLng, title:string=""):google.maps.Marker {
            return new google.maps.Marker({
                position: latLng,
                map: this.map,
                title: title
            });
        }

        createCircle(position:google.maps.LatLng, radius:number=100):google.maps.Circle {
            var option:google.maps.CircleOptions = {
                center : position,
                radius:radius,
                draggable : true,
                editable : true
            };
            return new google.maps.Circle(option);
        }

        init ():void {
            var mapOptions:google.maps.MapOptions = {
                zoom: 8,
                center:  this.createLatLng(22.73945682742318,90.75462353808598)
            };

            this.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
            var marker = this.createMaker(this.map.getCenter(), 'Click to zoom');
            marker.addListener(DomEventKind.CLICK, () => {
                this.map.panTo(marker.getPosition());
            });

            this.map.addListener(MapEventKind.CLICK,()=>{
                this.getLatLng("Bangladesh mosque");
                this.circle.setMap(this.map);
            });

            this.circle = this.createCircle(this.map.getCenter(),100000);
        }

        getLatLng(place:string) {

        // ジオコーダのコンストラクタ
            var geoCoder:google.maps.Geocoder = new google.maps.Geocoder();

        // geocodeリクエストを実行。
        // 第１引数はGeocoderRequest。住所⇒緯度経度座標の変換時はaddressプロパティを入れればOK。
        // 第２引数はコールバック関数。
            geoCoder.geocode({
            address: place
            }, (results, status)=> {
            if (status == google.maps.GeocoderStatus.OK) {

                // 結果の表示範囲。結果が１つとは限らないので、LatLngBoundsで用意。
                var bounds = new google.maps.LatLngBounds();

                for (var i in results) {
                    if (results[i].geometry) {

                        // 緯度経度を取得
                        var latLng:google.maps.LatLng = results[i].geometry.location;

                        // 住所を取得(日本の場合だけ「日本, 」を削除)
                        var address = results[i].formatted_address.split("バングラデシュ").join("");

                        // 検索結果地が含まれるように範囲を拡大
                        bounds.extend(latLng);
                        var maker:google.maps.Marker = new google.maps.Marker({
                            position: latLng,
                            map: this.map,
                            title:address
                        });
                        var info:google.maps.InfoWindow = new google.maps.InfoWindow({
                            content:address
                        });

                        var self:any = this;
                        maker.addListener(MapEventKind.CLICK,function(){
                            var infoWindow:google.maps.InfoWindow = new google.maps.InfoWindow({ content: this.getTitle() });
                            infoWindow.open(self.map, <google.maps.Marker>this);
                        });
                    }
                }

                this.map.fitBounds(bounds);

            } else if (status == google.maps.GeocoderStatus.ERROR) {
                alert("サーバとの通信時に何らかのエラーが発生！");
            } else if (status == google.maps.GeocoderStatus.INVALID_REQUEST) {
                alert("リクエストに問題アリ！geocode()に渡すGeocoderRequestを確認せよ！！");
            } else if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
                alert("短時間にクエリを送りすぎ！落ち着いて！！");
            } else if (status == google.maps.GeocoderStatus.REQUEST_DENIED) {
                alert("このページではジオコーダの利用が許可されていない！・・・なぜ！？");
            } else if (status == google.maps.GeocoderStatus.UNKNOWN_ERROR) {
                alert("サーバ側でなんらかのトラブルが発生した模様。再挑戦されたし。");
            } else if (status == google.maps.GeocoderStatus.ZERO_RESULTS) {
                alert("見つかりません");
            } else {
                alert("えぇ～っと・・、バージョンアップ？");
            }
        });
    }
    }

    export class MapEventKind {
        static CENTER_CHANGED:string = "center_changed";
        static CLICK:string = "click";
    }

    export class DomEventKind {
        static LOADED:string = "load";
        static CLICK:string = "click";
    }

    export class MainModel {

    }

}