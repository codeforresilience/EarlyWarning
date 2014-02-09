/// <reference path="google.maps.d.ts"/>
var ew;
(function (ew) {
    var MainController = (function () {
        function MainController() {
            var _this = this;
            this.model = new MainModel();

            window.addEventListener(DomEventKind.LOADED, function () {
                _this.init();
            });
        }
        MainController.prototype.createLatLng = function (lat, lng) {
            return new google.maps.LatLng(lat, lng);
        };

        MainController.prototype.createMaker = function (latLng, title) {
            if (typeof title === "undefined") { title = ""; }
            return new google.maps.Marker({
                position: latLng,
                map: this.map,
                title: title
            });
        };

        MainController.prototype.createCircle = function (position, radius) {
            if (typeof radius === "undefined") { radius = 100; }
            var option = {
                center: position,
                radius: radius,
                draggable: true,
                editable: true
            };
            return new google.maps.Circle(option);
        };

        MainController.prototype.init = function () {
            var _this = this;
            var mapOptions = {
                zoom: 8,
                center: this.createLatLng(22.73945682742318, 90.75462353808598)
            };

            this.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
			_this.getLatLng("Bangladesh mosque");

            this.circle = this.createCircle(this.map.getCenter(), 100000);
            _this.circle.setMap(_this.map);
            this.circle.addListener('center_changed', (function() {
                if (this.on_center_changed) {
                    this.on_center_changed(this.circle.center);
                }
            }).bind(this));

            this.circle.addListener('radius_changed', (function() {
                if (this.on_radius_changed) {
                    this.on_radius_changed(this.circle.radius);
                }
            }).bind(this));
        };

        MainController.prototype.getLatLng = function (place) {
            var _this = this;
            // ジオコーダのコンストラクタ
            var geoCoder = new google.maps.Geocoder();

            // geocodeリクエストを実行。
            // 第１引数はGeocoderRequest。住所⇒緯度経度座標の変換時はaddressプロパティを入れればOK。
            // 第２引数はコールバック関数。
            geoCoder.geocode({
                address: place
            }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    // 結果の表示範囲。結果が１つとは限らないので、LatLngBoundsで用意。
                    var bounds = new google.maps.LatLngBounds();

                    for (var i in results) {
                        if (results[i].geometry) {
                            // 緯度経度を取得
                            var latLng = results[i].geometry.location;

                            // 住所を取得(日本の場合だけ「日本, 」を削除)
                            var address = results[i].formatted_address.split("バングラデシュ").join("");

                            // 検索結果地が含まれるように範囲を拡大
                            bounds.extend(latLng);
                            var maker = new google.maps.Marker({
                                position: latLng,
                                map: _this.map,
                                title: address
                            });
                            var info = new google.maps.InfoWindow({
                                content: address
                            });

                            var self = _this;
                            maker.addListener(MapEventKind.CLICK, function () {
                                var infoWindow = new google.maps.InfoWindow({ content: this.getTitle() });
                                infoWindow.open(self.map, this);
                            });
                        }
                    }

                    _this.map.fitBounds(bounds);
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
        };
        return MainController;
    })();
    ew.MainController = MainController;

    var MapEventKind = (function () {
        function MapEventKind() {
        }
        MapEventKind.CENTER_CHANGED = "center_changed";
        MapEventKind.CLICK = "click";
        return MapEventKind;
    })();
    ew.MapEventKind = MapEventKind;

    var DomEventKind = (function () {
        function DomEventKind() {
        }
        DomEventKind.LOADED = "load";
        DomEventKind.CLICK = "click";
        return DomEventKind;
    })();
    ew.DomEventKind = DomEventKind;

    var MainModel = (function () {
        function MainModel() {
        }
        return MainModel;
    })();
    ew.MainModel = MainModel;
})(ew || (ew = {}));
